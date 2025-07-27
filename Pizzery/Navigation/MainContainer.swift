import SwiftUI

struct MainContainer: View {

    @StateObject
    var navController = NavController<Destination>(initial: .menu)

    var body: some View {
        VStack(spacing: 0) {
            if navController.currentRoute.showTopBar {
                TopBar(
                    title: navController.currentRoute.title,
                    showBackButton: navController.currentRoute.hasBackButton,
                    onBackClick: { navController.pop() },
                    content: topBarContent
                )
            }

            NavHost(navController) { route in
                switch route {
                case .login: LoginScreen()
                case .signIn: SignInScreen()
                case .menu: MenuScreen()
                case .notifications: NotificationScreen()
                case .favourites: FavouritesScreen()
                case .basket: BasketScreen()
                case .wallet: WalletScreen()
                case .orderInfo(let id): OrderInfoScreen(orderId: id)
                case .orders: OrderListScreen()
                case .profile: ProfileScreen()
                default: EmptyView()
                }
            }
            .fillMaxSize()
            .ignoresSafeArea()

            if navController.currentRoute.showNavBar {
                NavigationBar(navController: navController)
            }
        }
        .background(
            GradientBackground()
                .ignoresSafeArea()
        )
    }
}

extension MainContainer {

    @ViewBuilder
    fileprivate func topBarContent() -> some View {
        switch navController.currentRoute.route {

        case Destination.menu.route:
            Button(action: { navController.push(.notifications) }) {
                Image(.notifyCircle)
                    .resizable()
                    .frame(32)
            }

        default: Spacer().frame(height: 32)
        }
    }
}
