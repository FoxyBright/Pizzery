import SwiftUI

struct NotificationScreen: View {
    @EnvironmentObject private var mainVm: MainViewModel

    var body: some View {
        VStack {
            if mainVm.pendingNotifications {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack(spacing: 18) {
                        Spacer().frame(height: 6)

                        ForEach(mainVm.notifications, id: \.id) {
                            notification in
                            NotificationView(
                                notification: notification,
                                onDelete: {
                                    withAnimation {
                                        mainVm.removeNotification(
                                            id: notification.id
                                        )
                                    }
                                }
                            )
                            .padding(.horizontal, 16)
                            .transition(
                                .move(edge: .trailing)
                                    .combined(with: .opacity)
                            )
                        }

                        Spacer().frame(height: 30)
                    }
                }
                .refreshable { mainVm.updateNotifications(isRefresh: true) }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear { mainVm.updateNotifications() }
        .background(
            GradientBackground()
                .ignoresSafeArea()
        )
    }
}

private struct NotificationView: View {
    var notification: Notification
    @State private var isExpanded = false
    var onDelete: (@MainActor () -> Void)? = nil

    private var createdAt: String {
        return Date(notification.createdAt)
            .format("d MMMM yyyy HH:mm")
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Image(R.drawable.notificationBell)
                    .resizable()
                    .frame(width: 42, height: 42)
                    .foregroundColor(.gray3E3E3E)
                    .padding(.trailing, 14)

                VStack(alignment: .leading, spacing: 8) {
                    Text(notification.title)
                        .foregroundColor(.black)
                        .font(.bold14)
                        .lineLimit(1)
                    Text(notification.text)
                        .foregroundColor(.gray)
                        .font(.regular14)
                }

                Spacer()

                DefaultIconButton(
                    R.drawable.trash,
                    size: 20,
                    containerColor: Color.clear,
                    contentColor: Color.mainRed,
                    onClick: { onDelete?() }
                )
            }

            Text(createdAt)
                .font(.light10)
                .foregroundColor(.gray737373)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 14)
        }
        .padding(EdgeInsets(top: 14, leading: 8, bottom: 6, trailing: 12))
        .background(.grayF0F2F5)
        .clipped()
        .cornerRadius(16)
    }
}
