import SwiftUI

class OrdersViewModel: ObservableObject {
    // MARK: Wallet screen
    @Published var selectedPaymentMethod: PaymentMethod

    init() {
        if let card = BankCardRepository.shared.selectedCard {
            selectedPaymentMethod = .card(card: card)
        } else {
            selectedPaymentMethod = .cash
        }
    }

    func selectPaymentMethod(_ method: PaymentMethod) {
        let cardRepository = BankCardRepository.shared
        if case let .card(card) = method {
            cardRepository.selectCard(card)
        } else {
            cardRepository.selectCard(nil)
        }
        selectedPaymentMethod = method
    }
}
