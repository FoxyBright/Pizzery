import SwiftUI

struct NavigationBar: View {
    @ObservedObject
    var navController: NavController<Destination>

    var body: some View {
        HStack(spacing: 0) {
            ForEach(NavBarButton.allCases.indices, id: \.self) { index in
                let buttonData = NavBarButton.allCases[index]
                NavBarButtonView(
                    data: buttonData,
                    isSelected: buttonData.destination.route == navController.currentRoute.route,
                    onClick: {
                        navController.push(
                            buttonData.destination,
                            reset: true,
                            animated: false
                        )
                    }
                )
                if NavBarButton.allCases.count != (index + 1) {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
        .background(.gray3E3E3E)
    }
}

private enum NavBarButton: CaseIterable {
    case Menu, Favourites, Basket, Wallet, Profile

    var icon: String {
        switch self {
        case .Menu:
            return "navMenu"
        case .Wallet:
            return "navWallet"
        case .Basket:
            return "navBasket"
        case .Favourites:
            return "navFavorites"
        case .Profile:
            return "navProfile"
        }
    }

    var destination: Destination {
        switch self {
        case .Menu: return .menu
        case .Wallet: return .wallet
        case .Basket: return .basket
        case .Favourites: return .favourites
        case .Profile: return .profile
        }
    }
}

private struct NavBarButtonView: View {

    var data: NavBarButton
    var isSelected: Bool
    var onClick: @MainActor () -> Void

    var body: some View {
        Button(action: onClick) {
            Image(data.icon)
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundColor(.white)
                .background {
                    Circle()
                        .fill(isSelected ? .mainOrange : .clear)
                        .frame(width: 40, height: 40)
                }
        }
    }
}
