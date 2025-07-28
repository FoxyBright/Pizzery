import SwiftUI

struct WalletScreen: View {
    @EnvironmentObject
    private var ordersVm: OrdersViewModel
    @EnvironmentObject
    private var loginVm: LoginViewModel

    @StateObject
    private var cardsRepository = BankCardRepository.shared

    @State private var showAddCardSheet = false

    var body: some View {
        if let user = loginVm.user {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(Strings.personalWallet)
                        .font(.semibold16, .black)
                        .fillMaxWidth(alignment: .leading)
                        .lineLimit(1)
                        .padding(top: 46, bottom: 24)
                        .padding(start: 4)

                    paymentMethods(user: user)

                    OutlinedButton(
                        text: Strings.addCard,
                        leadingIcon: .plus,
                        iconSize: 16,
                        action: { showAddCardSheet = true }
                    )
                    .padding(vertical: 42)
                }
                .padding(horizontal: 16)
            }
            .background(.white)
            .sheet(isPresented: $showAddCardSheet) {
                AddCardBS(isPresented: $showAddCardSheet)
            }
        } else {
            NeedAuthScreen()
        }
    }
}

extension WalletScreen {
    fileprivate func paymentMethods(user: User) -> some View {
        VStack(spacing: 0) {
            PaymentMethodView(
                method: PaymentMethod.daddyPoints,
                isSelected: ordersVm.selectedPaymentMethod
                    == PaymentMethod.daddyPoints,
                balance: String(user.bonusBalance),
                onSelect: { ordersVm.selectPaymentMethod($0) }
            )

            Divider()
                .foregroundColor(.grayCBCBCB)
                .padding(horizontal: 16)

            ForEach(cardsRepository.cards, id: \.number) { card in
                PaymentMethodView(
                    method: .card(card: card),
                    isSelected: ordersVm.selectedPaymentMethod
                        == .card(card: card),
                    onSelect: { ordersVm.selectPaymentMethod($0) }
                )
                Divider()
                    .foregroundColor(.grayCBCBCB)
                    .padding(horizontal: 16)
            }

            PaymentMethodView(
                method: PaymentMethod.cash,
                isSelected: ordersVm.selectedPaymentMethod
                    == PaymentMethod.cash,
                onSelect: { ordersVm.selectPaymentMethod($0) }
            )
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.grayCBCBCB, lineWidth: 1)
                .background(.white)
                .clip(16)
        }
    }
}
