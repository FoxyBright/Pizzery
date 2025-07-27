import SwiftUI

struct NotificationCard: View {
    let notification: Notification
    var onDelete: (@MainActor () -> Void)? = nil

    @State private var isExpanded = false
    
    private var createdAt: String {
        return Date(notification.createdAt)
            .format("d MMMM yyyy HH:mm")
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Image(.notificationBell)
                    .resizable()
                    .tint(.gray3E3E3E)
                    .frame(42)
                    .padding(end: 14)

                VStack(alignment: .leading, spacing: 8) {
                    Text(notification.title)
                        .font(.bold14, .black)
                        .lineLimit(1)

                    Text(notification.text)
                        .font(.regular14, .gray)
                }

                Spacer()

                Button(action: { onDelete?() }) {
                    Image(.trash)
                        .resizable()
                        .tint(.mainRed)
                        .frame(20)
                }
            }

            Text(createdAt)
                .fillMaxWidth(alignment: .trailing)
                .font(.light10, .gray737373)
                .padding(top: 14)
        }
        .padding(top: 14, start: 8, bottom: 6, end: 12)
        .background(.grayF0F2F5)
        .clip(16)
    }
}
