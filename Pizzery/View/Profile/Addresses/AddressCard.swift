import SwiftUI

struct AddressCard: View {

    let address: Address
    let onEditClick: @MainActor () -> Void
    let onDeleteClick: @MainActor () -> Void

    var body: some View {
        HStack(spacing: 0) {
            Image(.home)
                .resizable()
                .frame(20)
                .tint(.mainCyan)
                .frame(48)
                .background(.white)
                .clipShape(Circle())

            Text(address.address)
                .font(.regular15, .gray737373)
                .padding(start: 16)

            Spacer()

            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    Button(action: onEditClick) {
                        Image(.edit)
                            .resizable()
                            .frame(18)
                            .tint(.gray3E3E3E)
                    }
                    Button(action: onDeleteClick) {
                        Image(.trash)
                            .resizable()
                            .frame(18)
                            .tint(.mainRed)
                    }
                }
                Spacer()
            }
        }
        .padding(12)
        .fillMaxWidth()
        .background(.grayF0F2F5)
        .clip(16)
    }
}
