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
        .padding(horizontal: 30)
        .padding(top: 20)
        .background(.gray3E3E3E)
    }
}

private enum NavBarButton: CaseIterable {
    case menu, favourites, basket, wallet, profile

    var icon: UIImage {
        switch self {
        case .menu: return .navMenu
        case .favourites: return .navFavorites
        case .basket: return .navBasket
        case .wallet: return .navWallet
        case .profile: return .navProfile
        }
    }

    var destination: Destination {
        switch self {
        case .menu: return .menu
        case .favourites: return .favourites
        case .basket: return .basket
        case .wallet: return .wallet
        case .profile: return .profile
        }
    }
}

private struct NavBarButtonView: View {
    let data: NavBarButton
    let isSelected: Bool
    let onClick: @MainActor () -> Void

    var body: some View {
        Button(action: onClick) {
            Image(uiImage: data.icon)
                .resizable()
                .tint(.white)
                .frame(22)
        }
        .padding(10)
        .background {
            Circle().fill(isSelected ? .mainOrange : .clear)
        }
    }
}
