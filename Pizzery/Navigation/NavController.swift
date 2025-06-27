import SwiftUI

class NavController<T: Equatable>: ObservableObject {

    private var _routes: [T] = []

    @Published public private(set) var currentRoute: T
    public var routes: [T] { return _routes }

    var onPush: ((T, Bool, Bool) -> Void)?
    var onPopLast: ((Int, Bool) -> Void)?

    public init(initial: T) {
        self.currentRoute = initial
        push(initial)
    }

    public func push(
        _ route: T,
        reset: Bool = false,
        animated: Bool = true
    ) {
        if reset { self._routes.removeAll() }
        self._routes.append(route)
        self.currentRoute = route
        self.onPush?(route, reset, animated)
    }

    public func pop(animated: Bool = true) {
        if self._routes.count > 1 {
            self._routes.removeLast()
            self.currentRoute = self._routes.last!
            onPopLast?(1, animated)
        }
    }

    public func popTo(
        _ route: T,
        inclusive: Bool = false,
        animated: Bool = true
    ) {
        guard var found = _routes.lastIndex(where: { $0 == route }) else {
            return
        }

        if !inclusive { found += 1 }

        let numToPop = (found..<_routes.endIndex).count
        _routes.removeLast(numToPop)
        self.currentRoute = _routes.last!
        onPopLast?(numToPop, animated)
    }

    public func onSystemPop() {
        if self._routes.isNotEmpty {
            self._routes.removeLast()
            self.currentRoute = self._routes.last!
        }
    }
}

struct NavHost<T: Equatable, Screen: View>: View {
    @StateObject var navigationStyle = NavStyle()
    @ViewBuilder let routeMap: (T) -> Screen
    let navController: NavController<T>

    public init(
        _ navController: NavController<T>,
        @ViewBuilder _ routeMap: @escaping (T) -> Screen
    ) {
        self.navController = navController
        self.routeMap = routeMap
    }

    public var body: some View {
        NavigationControllerHost(
            navController: navController,
            navTitle: navigationStyle.title,
            navHidden: navigationStyle.isHidden,
            routeMap: routeMap
        )
        .environmentObject(navController)
        .environment(\.uipNavigationStyle, navigationStyle)
    }
}

class NavStyle: ObservableObject {
    @Published var isHidden = true
    @Published var title = ""
    var isHiddenOwner: String = ""
    var titleOwner: String = ""
}

private struct NavigationControllerHost<T: Equatable, Screen: View>:
    UIViewControllerRepresentable
{
    let navController: NavController<T>
    let navTitle: String
    let navHidden: Bool

    @ViewBuilder
    var routeMap: (T) -> Screen

    func makeUIViewController(context: Context) -> UINavigationController {
        let navigation = PopAwareUINavigationController()

        navigation.stackSizeProvider = { navController.routes.count }
        navigation.popHandler = { navController.onSystemPop() }

        for path in navController.routes {
            navigation.pushViewController(
                UIHostingController(rootView: routeMap(path)),
                animated: true
            )
        }

        navController.onPush = { route, reset, animated in
            let newController = UIHostingController(
                rootView: routeMap(route)
            )
            if reset {
                navigation.setViewControllers(
                    [newController],
                    animated: animated
                )
            } else {
                navigation.pushViewController(
                    newController,
                    animated: animated
                )
            }
        }

        navController.onPopLast = { numToPop, animated in
            let vcs = navigation.viewControllers
            if numToPop >= vcs.count {
                if let root = vcs.first {
                    navigation.viewControllers = [root]
                } else {
                    navigation.viewControllers = []
                }
            } else {
                let popToIndex = vcs.count - numToPop - 1
                let popToVC = vcs[popToIndex]
                navigation.popToViewController(popToVC, animated: animated)
            }
        }

        return navigation
    }

    func updateUIViewController(
        _ navigation: UIViewControllerType,
        context: Context
    ) {
        navigation.topViewController?.navigationItem.title = navTitle
        navigation.navigationBar.isHidden = navHidden
    }

    static func dismantleUIViewController(
        _ navigation: UIViewControllerType,
        coordinator: ()
    ) {
        navigation.viewControllers = []
        (navigation as! PopAwareUINavigationController).popHandler = nil
    }
}

private class PopAwareUINavigationController:
    UINavigationController,
    UINavigationControllerDelegate
{
    var popHandler: (() -> Void)?
    var stackSizeProvider: (() -> Int)?

    var popGestureBeganController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        if let stackSizeProvider = stackSizeProvider,
            stackSizeProvider() > navigationController.viewControllers.count
        {
            self.popHandler?()
        }
    }
}

private struct NavigationTitleKey: EnvironmentKey {
    static let defaultValue: Binding<String> = .constant("")
}

private struct NavigationHiddenKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

private struct NavigationStyleKey: EnvironmentKey {
    static let defaultValue: NavStyle = NavStyle()
}

extension View {
    fileprivate func uipNavigationBarHidden(_ hidden: Bool) -> some View {
        return modifier(NavHiddenModifier(isHidden: hidden))
    }

    fileprivate func uipNavigationTitle(_ title: String) -> some View {
        return modifier(NavTitleModifier(title: title))
    }
}

extension EnvironmentValues {
    fileprivate var uipNavigationStyle: NavStyle {
        get { self[NavigationStyleKey.self] }
        set { self[NavigationStyleKey.self] = newValue }
    }

    fileprivate var upNavigationHidden: Binding<Bool> {
        get { self[NavigationHiddenKey.self] }
        set { self[NavigationHiddenKey.self] = newValue }
    }

    fileprivate var upNavigationTitle: Binding<String> {
        get { self[NavigationTitleKey.self] }
        set { self[NavigationTitleKey.self] = newValue }
    }
}

private struct NavTitleModifier: ViewModifier {
    @Environment(\.uipNavigationStyle) var navStyle
    @State var initialValue: String = ""
    @State var id = UUID().uuidString
    let title: String

    init(title: String) { self.title = title }

    func body(content: Content) -> some View {
        if navStyle.titleOwner == id && navStyle.title != title {
            DispatchQueue.main.async { navStyle.title = title }
        }
        return content.onAppear {
            initialValue = navStyle.title
            navStyle.title = title
            navStyle.titleOwner = id
        }.onDisappear {
            if navStyle.titleOwner == id {
                navStyle.title = initialValue
                navStyle.titleOwner = ""
            }
        }
    }
}

private struct NavHiddenModifier: ViewModifier {
    @Environment(\.uipNavigationStyle) var navStyle
    @State var initialValue: Bool = false
    @State var id = UUID().uuidString
    let isHidden: Bool

    func body(content: Content) -> some View {
        if navStyle.isHiddenOwner == id && navStyle.isHidden != isHidden {
            DispatchQueue.main.async { navStyle.isHidden = isHidden }
        }
        return content.onAppear {
            initialValue = navStyle.isHidden
            navStyle.isHidden = isHidden
            navStyle.isHiddenOwner = id
        }.onDisappear {
            if navStyle.isHiddenOwner == id {
                navStyle.isHidden = initialValue
                navStyle.isHiddenOwner = ""
            }
        }
    }
}
