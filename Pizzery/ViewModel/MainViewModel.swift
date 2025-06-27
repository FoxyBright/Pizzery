import SwiftUI

class MainViewModel: ObservableObject {

    // MARK: Main screen
    @Published var searchText: String = ""
    @Published var notifications: [Notification] = []
    
    // MARK: Loading states
    @Published var pendingNotifications: Bool = false

    func updateNotifications(isRefresh: Bool = false) {
        guard notifications.isEmpty || isRefresh else { return }
        pendingNotifications = !isRefresh
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            let result = (0..<50).map { _ in
                Notification(
                    id: Int64.random(in: 0..<Int64.max),
                    title: "Выгодно!",
                    text:
                        "Пригласите друга, показав ваш персональный код, и получите бонус!",
                    createdAt: Date().millis
                )
            }
            await MainActor.run {
                notifications = result
                pendingNotifications = false
            }
        }
    }

    func removeNotification(id: Int64) {
        notifications.removeAll { $0.id == id }
    }
}
