import SwiftUI

struct PaymentMethodView: View {
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
                                .tint(.gray3E3E3E)
                                .frame(24)
                        } else {
                            Image(card.system.rawValue)
                                .resizable()
                                .frame(width: 34, height: 24)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(.grayF4F0F0, lineWidth: 2)
                                        .clip(4)
                                }
                        }
                        Text("**** \(card.number.suffix(4))")
                            .font(.regular16, .black)
                    }

                case .cash:
                    HStack(spacing: 8) {
                        Image(R.drawable.money)
                            .resizable()
                            .tint(.mainGreen)
                            .frame(24)
                        Text(R.strings.cash)
                            .font(.regular16, .black)
                    }

                case .daddyPoints:
                    HStack(spacing: 8) {
                        Image(R.drawable.wallet)
                            .resizable()
                            .tint(.gray3E3E3E)
                            .frame(24)
                        Text(R.strings.daddyPoints)
                            .font(.regular16, .black)
                    }
                }

                Spacer()

                HStack(spacing: 10) {
                    if let balance = balance {
                        Text(balance)
                            .font(.semibold15, .black)
                    }
                    DefaultCheckBox(
                        isSelected: isSelected
                    ) { _ in
                        onSelect(method)
                    }
                }
                .padding(start: 10)
            }
            .animation(.easeInOut(duration: 0.2), value: isSelected)
            .fillMaxWidth()
            .padding(16)
        }
    }
}
