import SwiftUI

@main
struct PizzeryApp: App {
    
    // MARK: Init ViewModels
    @StateObject private var loginVm = LoginViewModel()
    @StateObject private var mainVm = MainViewModel()
    @StateObject private var ordersVm = OrdersViewModel()

    var body: some Scene {
        WindowGroup {
            MainContainer()
                .environmentObject(loginVm)
                .environmentObject(mainVm)
                .environmentObject(ordersVm)
        }
    }
}
