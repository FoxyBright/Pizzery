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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .font(.semibold16)
                    .lineLimit(1)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    .padding(.top, 46)

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
                        .padding(.horizontal, 16)

                    ForEach(cardsRepository.cards, id: \.number) { card in
                        PaymentMethodView(
                            method: .card(card: card),
                            isSelected: ordersVm.selectedPaymentMethod
                                == .card(card: card),
                            onSelect: { ordersVm.selectPaymentMethod($0) }
                        )
                        Divider()
                            .foregroundColor(.grayCBCBCB)
                            .padding(.horizontal, 16)
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
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)

                Button(action: { isShowingSheet = true }) {
                    HStack(spacing: 10) {
                        Image(R.drawable.plus)
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.mainOrange)
                        Text(R.strings.addCard)
                            .foregroundColor(.mainOrange)
                            .font(.bold14)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(22)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.grayF0F5FA, lineWidth: 2)
                            .background(.white)
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 42)
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            AddCardScreen(isPresented: $isShowingSheet)
        }
    }
}

private struct PaymentMethodView: View {
    var method: PaymentMethod
    var isSelected: Bool
    var balance: String? = nil
    var onSelect: (PaymentMethod) -> Void

    var body: some View {
        Button(action: { onSelect(method) }) {
            HStack(spacing: 0) {
                switch method {
                case let .card(card):
                    HStack(spacing: 8) {
                        if card.system == .unknown {
                            Image(R.drawable.wallet)
                                .resizable()
                                .frame(width: 24, height: 24)
                        } else {
                            Image(card.system.rawValue)
                                .resizable()
                                .frame(width: 34, height: 24)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(.grayF4F0F0, lineWidth: 2)
                                        .cornerRadius(4)
                                }
                        }
                        Text("**** \(card.number.suffix(4))")
                            .foregroundColor(.black)
                            .font(.regular16)
                    }

                case .cash:
                    HStack(spacing: 8) {
                        Image(R.drawable.money)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(R.strings.cash)
                            .foregroundColor(.black)
                            .font(.regular16)
                    }

                case .daddyPoints:
                    HStack(spacing: 8) {
                        Image(R.drawable.wallet)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(R.strings.daddyPoints)
                            .foregroundColor(.black)
                            .font(.regular16)
                    }
                }

                Spacer()

                HStack(spacing: 10) {
                    if let balance = balance {
                        Text(balance)
                            .foregroundColor(.black)
                            .font(.semibold15)
                    }
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(isSelected ? .mainOrange : .clear)
                        .overlay {
                            if isSelected {
                                Image(R.drawable.check)
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.white)
                            } else {
                                Circle()
                                    .strokeBorder(.gray94A3B3, lineWidth: 2)
                            }
                        }
                }
                .padding(.leading, 10)
            }
            .animation(.easeInOut(duration: 0.2), value: isSelected)
            .frame(maxWidth: .infinity)
            .padding(16)
        }
    }
}
