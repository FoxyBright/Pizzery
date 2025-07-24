import SwiftUI

class MainViewModel: ObservableObject {

    // MARK: Main screen
    @Published var searchText: String = ""
    @Published var notifications: [Notification] = []

    // MARK: Loading states
    @Published var pendingNotifications: Bool = false
    @Published var pendingMenuCategories: Bool = false

    @Published var posters: [Poster] = []
    @Published var menuCategories: [FoodCategory] = []

    func updateNotifications(isRefresh: Bool = false) {
        guard notifications.isEmpty || isRefresh else { return }
        pendingNotifications = !isRefresh
        Task {
            await delay(1_000)
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

    func getMenuData(isRefresh: Bool = false) {
        getPosters()
        getMenu(isRefresh: isRefresh)
    }

    private func getPosters() {
        Task {
            await delay(3_000)
            let result = (0..<6).map { _ in
                Poster(
                    id: Int64.random(in: .min ... .max),
                    imageUrls: [
                        "https://sun9-73.userapi.com/impg/c854424/v854424634/237236/kw29-eXYji0.jpg?size=604x363&quality=96&sign=a31c267273d02a2e5339237e3b34de4d&type=album"
                    ],
                    imageQty: 1,
                    visible: true
                )
            }
            await MainActor.run {
                posters = result
            }
        }
    }

    private func getMenu(isRefresh: Bool = false) {
        pendingMenuCategories = !isRefresh
        Task {
            await delay(1_000)
            let result = (0..<10).map { index in
                FoodCategory(
                    id: Int64.random(in: .min ... .max),
                    name: "Пицца \(index)",
                    imageUrl: "https://i.pinimg.com/originals/1b/b9/74/1bb974de8c8f34427973c8c48e4875ce.jpg",
                    hasSale: index % 2 == 0,
                    isNew: index % 3 != 0
                )
            }
            await MainActor.run {
                menuCategories = result
                pendingMenuCategories = false
            }
        }
    }
}
