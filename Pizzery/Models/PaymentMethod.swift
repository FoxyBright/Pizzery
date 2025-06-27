enum PaymentMethod: Equatable {
    case cash
    case card(card: Card)
    case daddyPoints
}
