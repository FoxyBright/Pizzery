import SwiftUI

struct MainContainer: View {

    @StateObject
    var navController = NavController<Destination>(initial: .menu)

    var body: some View {
        NavHost(navController) { route in
            VStack(spacing: 0) {
                if navController.currentRoute.showTopBar {
                    TopBar(
                        title: navController.currentRoute.title,
                        showBackButton: navController.currentRoute.hasBackButton,
                        onBackClick: { navController.pop() },
                        content: topBarContent
                    )
                }

                ZStack {
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
                .background(
                    GradientBackground()
                        .ignoresSafeArea()
                )

                if navController.currentRoute.showNavBar {
                    NavigationBar(navController: navController)
                }
            }
        }
        .fillMaxSize()
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func topBarContent() -> some View {
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
