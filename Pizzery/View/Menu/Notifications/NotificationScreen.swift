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

                        ForEach(mainVm.notifications, id: \.id) { item in
                            notificationCard(item)
                        }
                        .padding(horizontal: 16)

                        Spacer().frame(height: 30)
                    }
                } 
            }
        }
        .fillMaxSize()
        .refreshable { mainVm.updateNotifications(isRefresh: true) }
        .onAppear { mainVm.updateNotifications() }
        .background(GradientBackground().ignoresSafeArea())
    }
}

extension NotificationScreen {

    fileprivate func notificationCard(
        _ notification: Notification
    ) -> some View {
        NotificationCard(
            notification: notification,
            onDelete: {
                withAnimation {
                    mainVm.removeNotification(
                        id: notification.id
                    )
                }
            }
        )
        .transition(
            .move(edge: .trailing)
                .combined(with: .opacity)
        )
    }
}
