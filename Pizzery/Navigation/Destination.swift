import SwiftUI

enum Destination: Equatable {

    case login
    case signIn
    case menu
    case notifications
    case favourites
    case basket
    case wallet
    case profile
    case account
    case addresses
    case orders
    case orderInfo(id: Int64)

    var route: String {
        switch self {
        case .login: return "login"
        case .signIn: return "signIn"
        case .menu: return "menu"
        case .notifications: return "notifications"
        case .favourites: return "favourites"
        case .basket: return "basket"
        case .wallet: return "wallet"
        case .profile: return "profile"
        case .account: return "account"
        case .addresses: return "addresses"
        case .orders: return "orders"
        case .orderInfo(let id): return "orderInfo/\(id)"
        }
    }

    var title: String {
        switch self {
        case .menu: return Strings.menu
        case .notifications: return Strings.notifications
        case .favourites: return Strings.favourites
        case .basket: return Strings.basket
        case .wallet: return Strings.wallet
        case .profile: return Strings.profile
        case .account: return Strings.accountData
        case .addresses: return Strings.addresses
        case .orders: return Strings.orders
        default: return ""
        }
    }

    var showTopBar: Bool {
        switch self {
        case .login,
            .signIn:
            return false
        default: return true
        }
    }

    var showNavBar: Bool {
        switch self {
        case .login,
            .signIn,
            .notifications,
            .account,
            .addresses,
            .orders:
            return false
        default: return true
        }
    }

    var hasBackButton: Bool {
        switch self {
        case .notifications,
            .account,
            .addresses,
            .orders:
            return true
        default: return false
        }
    }
}
