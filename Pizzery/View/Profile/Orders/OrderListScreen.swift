import SwiftUI

struct OrderListScreen: View {

    let data: [OrderInfo] = [
        TEST_ORDER, TEST_ORDER,
        TEST_ORDER, TEST_ORDER,
        TEST_ORDER, TEST_ORDER,
        TEST_ORDER, TEST_ORDER,
        TEST_ORDER, TEST_ORDER,
        TEST_ORDER, TEST_ORDER,
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                Spacer().frame(height: 16)
                ForEach(data, id: \.id) { order in
                    OrderCard(
                        order: order,
                        onRepeatClick: {
                            // TODO: on repeat order click
                        }
                    )
                }
                Spacer().frame(height: 16)
            }
            .padding(horizontal: 16)
        }
    }
}
