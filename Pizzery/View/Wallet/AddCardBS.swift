import SwiftUI

struct AddCardBS: View {
    @StateObject
    private var cardsRepository = BankCardRepository.shared
    @Binding var isPresented: Bool

    @State private var number = ""
    @State private var holderName = ""
    @State private var cvv = ""
    @State private var date = ""

    var body: some View {
        VStack(spacing: 0) {
            Color.gray828181
                .frame(width: 50, height: 5)
                .clip(50)
                .padding(vertical: 6)

            ScrollView {
                VStack(spacing: 0) {
                    Text(R.strings.addCard)
                        .font(.regular24, .black)
                        .fillMaxWidth(alignment: .leading)
                        .padding(top: 20)

                    Text(R.strings.fillCardData)
                        .font(.regular14, .gray828181)
                        .fillMaxWidth(alignment: .leading)
                        .padding(top: 12, bottom: 24)

                    VStack(spacing: 16) {
                        cardNumberField()
                        HStack(spacing: 13) {
                            expirationDateField()
                            cvvField()
                        }
                        cardholderNameField()
                    }

                    DefaultButton(
                        text: R.strings.continueStr,
                        enabled: number.count == 19
                            && date.count == 5
                            && cvv.count >= 3
                            && holderName.isNotEmpty,
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
                        }
                    )
                    .padding(vertical: 40)
                }
                .padding(horizontal: 24)
            }
        }
    }
}

extension AddCardBS {

    fileprivate func cardNumberField() -> some View {
        DefaultTextField(
            text: $number,
            label: R.strings.cardNumber,
            placeholder: "0000 0000 0000 0000",
            keyboardType: .numberPad
        ) { value in
            number = value.filter { $0.isNumber }
                .applyMask("**** **** **** ****", changedChar: "*")
        }
    }

    private var datePlaceholder: String {
        return Calendar.current
            .date(byAdding: .year, value: 4, to: Date())?
            .format("MM/yy") ?? "00/00"
    }

    fileprivate func expirationDateField() -> some View {
        DefaultTextField(
            text: $date,
            label: R.strings.expirationDate,
            placeholder: datePlaceholder,
            keyboardType: UIKeyboardType.numberPad,
        ) { value in
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
    }

    fileprivate func cvvField() -> some View {
        DefaultTextField(
            text: $cvv,
            label: R.strings.cvv,
            placeholder: "1234",
            keyboardType: .numberPad,
            hasInfoButton: true,
            onInfoCLick: {
                // TODO: on info click
            }
        ) { value in
            cvv = value.filter { $0.isNumber }
                .applyMask("****", changedChar: "*")
        }
    }

    fileprivate func cardholderNameField() -> some View {
        DefaultTextField(
            text: $holderName,
            label: R.strings.cardHolder,
            placeholder: R.strings.enterCardHolderName,
            setAutocapitalization: true
        ) { value in
            let allowed = value.filter {
                ($0.isASCII && $0.isLetter) || $0.isWhitespace
            }
            let endsWithSpace = allowed.last?.isWhitespace ?? false
            let words = allowed.split(whereSeparator: \.isWhitespace).prefix(2)
            var result = words.joined(separator: " ")
            if endsWithSpace && words.count == 1 { result.append(" ") }
            holderName = result.uppercased()
        }
    }
}
