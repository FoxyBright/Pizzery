import Foundation

/// Project resources
enum R {

    /// String resources with localization
    enum strings {
        // MARK: Login
        static var terms: String { localizedStr("terms") }
        static var termsOfUse: String { localizedStr("termsOfUse") }
        static var privacyPolicy: String { localizedStr("privacyPolicy") }
        static var enterPhoneNumber: String { localizedStr("enterPhoneNumber") }
        static var sendCode: String { localizedStr("sendCode") }
        static var weSendCode: String { localizedStr("weSendCode") }
        static var getCode: String { localizedStr("getCode") }
        static var enterCode: String { localizedStr("enterCode") }
        static var codeWasSentTo: String { localizedStr("codeWasSentTo") }
        static var smsCode: String { localizedStr("smsCode") }
        static var signIn: String { localizedStr("signIn") }

        // MARK: Basket
        static var basket: String { localizedStr("basket") }

        // MARK: Menu
        static var hotDaddyPizza: String { localizedStr("hotDaddyPizza") }
        static var menu: String { localizedStr("menu") }
        static var notifications: String { localizedStr("notifications") }

        // MARK: Favourites
        static var favourites: String { localizedStr("favourites") }

        // MARK: Wallet
        static var wallet: String { localizedStr("wallet") }
        static var cash: String { localizedStr("cash") }
        static var daddyPoints: String { localizedStr("daddyPoints") }
        static var addCard: String { localizedStr("addCard") }
        static var fillCardData: String { localizedStr("fillCardData") }
        static var cardHolder: String { localizedStr("cardHolder") }
        static var enterCardHolderName: String { localizedStr("enterCardHolderName") }
        static var cardNumber: String { localizedStr("cardNumber") }
        static var expirationDate: String { localizedStr("expirationDate") }
        static var cvv: String { localizedStr("cvv") }
        static var personalWallet: String { localizedStr("personalWallet") }

        // MARK: Profile
        static var profile: String { localizedStr("profile") }
        static var accountData: String { localizedStr("accountData") }
        static var addresses: String { localizedStr("addresses") }
        static var deleteAccount: String { localizedStr("deleteAccount") }
        static var orders: String { localizedStr("orders") }

        // MARK: Other
        static var searchPlaceholder: String { localizedStr("searchPlaceholder") }
        static var continueStr: String { localizedStr("continueStr") }
        static var exitStr: String { localizedStr("exitStr") }
    }

    /// Drawable resources
    enum drawable {
        static var magnifire: String { "magnifire" }
        static var logo: String { "logo" }
        static var arrowRight: String { "arrowRight" }
        static var loginBackground: String { "loginBackground" }
        static var notificationBell: String { "notificationBell" }
        static var trash: String { "trash" }
        static var profile: String { "profile" }
        static var map: String { "map" }
        static var orderPackage: String { "orderPackage" }
        static var deleteTrash: String { "deleteTrash" }
        static var exitIcon: String { "exit" }
        static var nextButton: String { "nextButton" }
        static var info: String { "info" }
        static var plus: String { "plus" }
        static var wallet: String { "wallet" }
        static var money: String { "money" }
        static var check: String { "check" }
        static var heart: String { "heart" }
        static var backButton: String { "backButton" }
        static var notifyCircle: String { "notifyCircle" }
        static var navMenu: String { "navMenu" }
        static var navWallet: String { "navWallet" }
        static var navBasket: String { "navBasket" }
        static var navFavorites: String { "navFavorites" }
        static var navProfile: String { "navProfile" }
    }

    /// localization strings method
    private static func localizedStr(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
}
