import SwiftUI

struct NotificationScreen: View {
    @EnvironmentObject private var mainVm: MainViewModel

    var body: some View {
        VStack {
            if mainVm.pendingNotifications {
                ProgressView()
            } else {
                notificationsList().refreshable {
                    mainVm.updateNotifications(isRefresh: true)
                }
            }
        }
        .fillMaxSize()
        .onAppear { mainVm.updateNotifications() }
        .background(GradientBackground().ignoresSafeArea())
    }
}

extension NotificationScreen {

    func notificationsList() -> some View {
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
                    .padding(horizontal: 16)
                    .transition(
                        .move(edge: .trailing)
                            .combined(with: .opacity)
                    )
                }

                Spacer().frame(height: 30)
            }
        }
    }
}
