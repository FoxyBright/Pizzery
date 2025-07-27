// This file is generated automatically using the
// Resources Generator bash script.
// Do not try to change it manually.

import Foundation

enum Strings {

    /// Личные данные 
    static var accountData: String { localizedStr("accountData") }

    /// Добавить новую карту 
    static var addCard: String { localizedStr("addCard") }

    /// Адреса 
    static var addresses: String { localizedStr("addresses") }

    /// Корзина 
    static var basket: String { localizedStr("basket") }

    /// Владелец карты 
    static var cardHolder: String { localizedStr("cardHolder") }

    /// Номер карты 
    static var cardNumber: String { localizedStr("cardNumber") }

    /// Наличные 
    static var cash: String { localizedStr("cash") }

    /// Мы отправили код на номер: %@ 
    static func codeWasSentTo(arg1: String) -> String {
        let localizedStr = NSLocalizedString("codeWasSentTo", comment: "codeWasSentTo")
        return String(format: localizedStr, arg1)
    }

    /// Продолжить 
    static var continueStr: String { localizedStr("continueStr") }

    /// CVV/CVC 
    static var cvv: String { localizedStr("cvv") }

    /// Daddy баллы 
    static var daddyPoints: String { localizedStr("daddyPoints") }

    /// Удалить аккаунт 
    static var deleteAccount: String { localizedStr("deleteAccount") }

    /// Введите имя владельца 
    static var enterCardHolderName: String { localizedStr("enterCardHolderName") }

    /// Введите код из смс 
    static var enterCode: String { localizedStr("enterCode") }

    /// Введите ваш номер телефона 
    static var enterPhoneNumber: String { localizedStr("enterPhoneNumber") }

    /// Выйти 
    static var exitStr: String { localizedStr("exitStr") }

    /// Срок годности 
    static var expirationDate: String { localizedStr("expirationDate") }

    /// Избранное 
    static var favourites: String { localizedStr("favourites") }

    /// Заполните данные вашей карты 
    static var fillCardData: String { localizedStr("fillCardData") }

    /// Получить код 
    static var getCode: String { localizedStr("getCode") }

    /// Перейти к авторизации 
    static var goToAutorization: String { localizedStr("goToAutorization") }

    /// Hot_Daddy_Pizza 
    static var hotDaddyPizza: String { localizedStr("hotDaddyPizza") }

    /// Меню 
    static var menu: String { localizedStr("menu") }

    /// Чтобы использовать данный функционал необходимо авторизоваться 
    static var needAuthorization: String { localizedStr("needAuthorization") }

    /// Уведомления 
    static var notifications: String { localizedStr("notifications") }

    /// Заказы 
    static var orders: String { localizedStr("orders") }

    /// Личный кошелёк 
    static var personalWallet: String { localizedStr("personalWallet") }

    /// Политику конфиденциальности 
    static var privacyPolicy: String { localizedStr("privacyPolicy") }

    /// Профиль 
    static var profile: String { localizedStr("profile") }

    /// Поиск… 
    static var searchPlaceholder: String { localizedStr("searchPlaceholder") }

    /// Отправить код 
    static var sendCode: String { localizedStr("sendCode") }

    /// Вход 
    static var signIn: String { localizedStr("signIn") }

    /// Код из смс 
    static var smsCode: String { localizedStr("smsCode") }

    /// Условия 
    static var terms: String { localizedStr("terms") }

    /// Продолжая, вы соглашаетесь, что прочитали и принимаете наши Условия и Политику конфиденциальности. 
    static var termsOfUse: String { localizedStr("termsOfUse") }

    /// Оплата 
    static var wallet: String { localizedStr("wallet") }

    /// Мы отправим вам код для подтверждения вашего номера телефона. 
    static var weSendCode: String { localizedStr("weSendCode") }

    private static func localizedStr(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
}
