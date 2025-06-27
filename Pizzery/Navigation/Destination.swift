import SwiftUI

enum Destination: Equatable {

    // MARK: Login screens
    case login, signIn

    // MARK: Menu screens
    case menu, notifications

    // MARK: Wallet screens
    case wallet

    // MARK: Basket screens
    case basket

    // MARK: Profile screens
    case profile, account, addresses, orders

    // MARK: Favourites screens
    case favourites

    // MARK: params screen
    // case detail(id: Int)

    var route: String {
        switch self {
        // MARK: Login screens
        case .login: return "login"
        case .signIn: return "signin"

        // MARK: Menu screens
        case .menu: return "menu"
        case .notifications: return "notifications"

        // MARK: Wallet screens
        case .wallet: return "wallet"

        // MARK: Basket screens
        case .basket: return "basket"

        // MARK: Favourites screens
        case .favourites: return "favourites"

        // MARK: Profile screens
        case .profile: return "profile"
        case .account: return "account"
        case .addresses: return "addresses"
        case .orders: return "orders"
        }
    }

    var title: String {
        switch self {
        // MARK: Login screens
        case .login, .signIn: return ""

        // MARK: Menu screens
        case .menu: return String.resource("menu")
        case .notifications: return String.resource("notifications")

        // MARK: Wallet screens
        case .wallet: return String.resource("wallet")

        // MARK: Basket screens
        case .basket: return String.resource("basket")

        // MARK: Favourites screens
        case .favourites: return String.resource("favourites")

        // MARK: Profile screens
        case .profile: return String.resource("profile")
        case .account: return String.resource("accountData")
        case .addresses: return String.resource("addresses")
        case .orders: return String.resource("orders")
        }
    }

    var showTopBar: Bool {
        switch self {
        case .login, .signIn: return false
        default: return true
        }
    }

    var showNavBar: Bool {
        switch self {
        case .login, .signIn: return false
        case .notifications: return false
        case .account, .addresses, .orders: return false
        default: return true
        }
    }

    var hasBackButton: Bool {
        switch self {
        case .notifications: return true
        case .account, .addresses, .orders: return true
        default: return false
        }
    }
}
