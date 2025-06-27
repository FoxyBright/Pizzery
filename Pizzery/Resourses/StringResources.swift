enum StringResources: String {

    // MARK: Login
    case tersm
    
    // MARK: Wallet
    case addCard,
        cardNumber,
        expirationDate,
        expirationDatePlaceholder,
        cvv,
        cardHolder,
        enterCardHolderName

    // MARK: Other
    case continueStr

    var value: String { .resource(rawValue) }
}
