import SwiftUI

struct BasketScreen: View {
    @EnvironmentObject
    private var loginVm: LoginViewModel
    
    var body: some View {
        if loginVm.user != nil {
            EmptyView()
        } else {
            NeedAuthScreen()
        }
    }
}
