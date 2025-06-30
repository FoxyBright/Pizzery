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
        case .menu: return R.strings.menu
        case .notifications: return R.strings.notifications
        case .favourites: return R.strings.favourites
        case .basket: return R.strings.basket
        case .wallet: return R.strings.wallet
        case .profile: return R.strings.profile
        case .account: return R.strings.accountData
        case .addresses: return R.strings.addresses
        case .orders: return R.strings.orders
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
