import SwiftUI

struct CustomTextField: View {
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
                    .font(.semibold14, .gray3E3E3E)
                    .lineLimit(1)

                Spacer()

                if hasInfoButton {
                    Button(action: onInfoCLick) {
                        Image(.info)
                            .resizable()
                            .tint(.gray828181)
                            .frame(20)
                    }
                }
            }
            TextField(placeholder, text: $text)
                .font(.regular15, .black)
                .disableAutocorrection(true)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(
                    setAutocapitalization ? .characters : .never
                )
        }
        .padding(horizontal: 16, vertical: 14)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.clear, lineWidth: 2)
                .background(.grayF2F2F2)
                .clip(12)
        }
        .onChange(of: text, perform: onTextChange)
    }
}
