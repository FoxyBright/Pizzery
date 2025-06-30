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
                    content: { TopBarContent(navController: navController) }
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

private struct TopBarContent: View {
    @ObservedObject var navController: NavController<Destination>

    var body: some View {
        switch navController.currentRoute.route {
        case Destination.menu.route:
            DefaultIconButton("notifyCircle", size: 32) {
                navController.push(.notifications)
            }

        default: Spacer().frame(height: 32)
        }
    }
}
