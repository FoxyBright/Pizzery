import SwiftUI

struct OrderCard: View {
    let order: OrderInfo
    let onRepeatClick: @MainActor () -> Void

    var body: some View {
        Text("Order: \(order.id)")
    }
}
