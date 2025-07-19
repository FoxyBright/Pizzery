import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onTextChange: (String) -> Void

    var body: some View {
        HStack(spacing: 18) {
            Image(R.drawable.magnifire)
                .resizable()
                .tint(.black)
                .frame(24)
            
            TextField(R.strings.searchPlaceholder, text: $text)
                .font(.medium18, .black)
                .onChange(of: text, perform: onTextChange)
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 50)
                .stroke(.black, lineWidth: 1)
                .background(.white)
                .clip(50)
        }
    }
}
