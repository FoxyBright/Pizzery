import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onTextChange: (String) -> Void

    var body: some View {
        HStack(spacing: 18) {
            Image("magnifire")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
            TextField("searchPlaceholder", text: $text)
                .foregroundColor(.black)
                .font(.medium18)
                .onChange(of: text) { newValue in
                    onTextChange(newValue)
                }
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 50)
                .stroke(.black, lineWidth: 1)
                .background(.white)
                .cornerRadius(50)
        }
    }
}
