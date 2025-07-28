import SwiftUI

struct AddressesScreen: View {

    private let data = [
        TEST_ADDRESS, TEST_ADDRESS,
        TEST_ADDRESS, TEST_ADDRESS,
        TEST_ADDRESS, TEST_ADDRESS,
        TEST_ADDRESS, TEST_ADDRESS,
        TEST_ADDRESS, TEST_ADDRESS,
        TEST_ADDRESS, TEST_ADDRESS,
        TEST_ADDRESS, TEST_ADDRESS,
        TEST_ADDRESS, TEST_ADDRESS,
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                Spacer().frame(height: 16)
                ForEach(data, id: \.id) { address in
                    AddressCard(
                        address: address,
                        onEditClick: {
                            // TODO: on edit address click
                        },
                        onDeleteClick: {
                            // TODO: on delete address click
                        }
                    )
                }
                Spacer().frame(height: 16)
            }
            .padding(horizontal: 16)
        }
    }
}
