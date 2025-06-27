import SwiftUI

struct AddCardScreen: View {
    @StateObject
    private var cardsRepository = BankCardRepository.shared
    @Binding var isPresented: Bool

    @State private var number = ""
    @State private var holderName = ""
    @State private var cvv = ""
    @State private var date = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(String.resource(.addCard))
                    .font(.title2)
                    .padding()

                VStack(spacing: 16) {
                    CardTextField(
                        text: $number,
                        label: String.resource(.cardNumber),
                        placeholder: "0000 0000 0000 0000",
                        keyboardType: UIKeyboardType.numberPad,
                    ) { text in
                        let masked =
                            text.filter { $0.isNumber }
                            .applyMask("**** **** **** ****", changedChar: "*")
                        if masked != text {
                            number = masked
                        }
                    }
                    HStack(spacing: 13) {
                        CardTextField(
                            text: $date,
                            label: String.resource(.expirationDate),
                            placeholder: "01/29",
                            keyboardType: UIKeyboardType.numberPad,
                        ) { text in
                            let masked =
                                text.filter { $0.isNumber }
                                .applyMask("**/**", changedChar: "*")
                            if masked != text {
                                date = masked
                            }
                        }
                        CardTextField(
                            text: $cvv,
                            label: String.resource(.cvv),
                            placeholder: "1234",
                            keyboardType: .numberPad,
                            hasInfoButton: true,
                            onInfoCLick: {
                                // TODO: on info click
                            }
                        ) { text in
                            let masked =
                                text.filter { $0.isNumber }
                                .applyMask("****", changedChar: "*")
                            if masked != text {
                                cvv = masked
                            }
                        }
                    }

                    CardTextField(
                        text: $holderName,
                        label: String.resource(.cardHolder),
                        placeholder: String.resource(.enterCardHolderName)
                    ) { text in
                        holderName = text
                    }
                }

                DefaultButton(
                    text: String.resource(.continueStr),
                    action: {
                        cardsRepository.addCard(
                            Card(
                                number: number,
                                expiryDate: 00,
                                cvc: cvv,
                                holder: holderName
                            )
                        )
                        isPresented = false
                    },
                )
                .padding(.vertical, 40)

            }.padding(.horizontal, 24)
        }
    }
}

private struct CardTextField: View {
    @Binding var text: String
    var label: String = ""
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    var hasInfoButton: Bool = false
    var onInfoCLick: () -> Void = {}
    var onTextChange: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .foregroundColor(.gray3E3E3E)
                    .font(.semibold14)
                    .lineLimit(1)
                Spacer()
                if hasInfoButton {
                    Button(action: onInfoCLick) {
                        Image("info")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray828181)
                    }
                }
            }
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .foregroundColor(.black)
                .font(.regular15)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.clear, lineWidth: 2)
                .background(.grayF2F2F2)
                .cornerRadius(12)
        }
        .onChange(of: text) { text in
            onTextChange(text)
        }
    }
}
