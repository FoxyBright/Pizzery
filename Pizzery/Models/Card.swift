struct Card: Hashable, Codable, Equatable {
    let number: String
    let expiryDate: Int64
    let cvc: String
    let holder: String
    
    var system: PaymentSystem {
        PaymentSystem.getByCardNumber(number)
    }
}
