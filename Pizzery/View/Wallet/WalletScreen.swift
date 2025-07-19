import SwiftUI

struct WalletScreen: View {
    @EnvironmentObject
    private var ordersVm: OrdersViewModel
    @EnvironmentObject
    private var loginVm: LoginViewModel

    @StateObject
    private var cardsRepository = BankCardRepository.shared

    @State private var isShowingSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text(R.strings.personalWallet)
                    .font(.semibold16, .black)
                    .fillMaxWidth(alignment: .leading)
                    .lineLimit(1)
                    .padding(top: 46, bottom: 24)
                    .padding(horizontal: 20)

                VStack(spacing: 0) {
                    PaymentMethodView(
                        method: PaymentMethod.daddyPoints,
                        isSelected: ordersVm.selectedPaymentMethod
                            == PaymentMethod.daddyPoints,
                        balance: String(loginVm.user?.bonusBalance ?? 0),
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
                .padding(horizontal: 16)

                Button(action: { isShowingSheet = true }) {
                    HStack(spacing: 10) {
                        Image(R.drawable.plus)
                            .resizable()
                            .tint(.mainOrange)
                            .frame(10)
                        Text(R.strings.addCard)
                            .font(.bold14, .mainOrange)
                    }
                    .fillMaxWidth()
                    .padding(22)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.grayF0F5FA, lineWidth: 2)
                            .background(.white)
                            .clip(16)
                    }
                }
                .padding(horizontal: 16, vertical: 42)
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            AddCardBS(isPresented: $isShowingSheet)
        }
    }
}
