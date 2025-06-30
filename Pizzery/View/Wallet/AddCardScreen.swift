import SwiftUI

struct AddCardScreen: View {
    @StateObject
    private var cardsRepository = BankCardRepository.shared
    @Binding var isPresented: Bool

    @State private var number = ""
    @State private var holderName = ""
    @State private var cvv = ""
    @State private var date = ""

    private var datePlaceholder: String {
        return Calendar.current
            .date(byAdding: .year, value: 4, to: Date())?
            .format("MM/yy") ?? "00/00"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(R.strings.addCard)
                    .font(.title2)
                    .padding()

                VStack(spacing: 16) {
                    CardTextField(
                        text: $number,
                        label: R.strings.cardNumber,
                        placeholder: "0000 0000 0000 0000",
                        keyboardType: UIKeyboardType.numberPad,
                        onTextChange: onCardNumberChange
                    )

                    HStack(spacing: 13) {
                        CardTextField(
                            text: $date,
                            label: R.strings.expirationDate,
                            placeholder: datePlaceholder,
                            keyboardType: UIKeyboardType.numberPad,
                            onTextChange: onDateChange
                        )

                        CardTextField(
                            text: $cvv,
                            label: R.strings.cvv,
                            placeholder: "1234",
                            keyboardType: .numberPad,
                            hasInfoButton: true,
                            onInfoCLick: {
                                // TODO: on info click
                            },
                            onTextChange: onCVVChange
                        )
                    }

                    CardTextField(
                        text: $holderName,
                        label: R.strings.cardHolder,
                        placeholder: R.strings.enterCardHolderName,
                        setAutocapitalization: true,
                        onTextChange: onCardHolderNameChange
                    )
                }

                DefaultButton(
                    text: R.strings.continueStr,
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

    private func onCardNumberChange(_ value: String) {
        number = value.filter { $0.isNumber }
            .applyMask("**** **** **** ****", changedChar: "*")
    }

    private func onDateChange(_ value: String) {
        let filtered = value.filter { $0.isNumber }
        var chars = Array(filtered.applyMask("**/**", changedChar: "*"))

        if chars.count >= 2 {
            if let inputYear = Int(String(chars[0...1])) {
                let month = String(
                    format: "%02d",
                    max(1, min(12, inputYear))
                )
                chars[0] = month.first!
                chars[1] = month.last!
            }
        }

        if chars.count >= 5 {
            if let inputYear = Int(String(chars[3...4])) {
                let currentYear =
                    Calendar.current
                    .component(.year, from: Date()) % 100
                let year = String(
                    format: "%02d",
                    max(currentYear, inputYear)
                )
                chars[3] = year.first!
                chars[4] = year.last!
            }
        }

        date = String(chars)
    }

    private func onCVVChange(_ value: String) {
        cvv = value.filter { $0.isNumber }.applyMask("****", changedChar: "*")
    }

    private func onCardHolderNameChange(_ value: String) {
        let allowed = value.filter { ($0.isASCII && $0.isLetter) || $0.isWhitespace }
        let endsWithSpace = allowed.last?.isWhitespace ?? false
        let words = allowed.split(whereSeparator: \.isWhitespace).prefix(2)
        var result = words.joined(separator: " ")
        if endsWithSpace && words.count == 1 { result.append(" ") }
        holderName = result.uppercased()
    }
}

private struct CardTextField: View {
    @Binding var text: String
    var label: String = ""
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    var hasInfoButton: Bool = false
    var setAutocapitalization: Bool = false
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
                        Image(R.drawable.info)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray828181)
                    }
                }
            }
            TextField(placeholder, text: $text)
                .disableAutocorrection(true)
                .keyboardType(keyboardType)
                .foregroundColor(.black)
                .textInputAutocapitalization(
                    setAutocapitalization ? .characters : .never
                )
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
