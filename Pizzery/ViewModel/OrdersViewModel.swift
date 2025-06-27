import SwiftUI

class OrdersViewModel: ObservableObject {
    // MARK: Wallet screen
    @Published var selectedPaymentMethod: PaymentMethod = .cash
}
