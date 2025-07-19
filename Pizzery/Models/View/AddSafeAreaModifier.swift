import SwiftUI

struct AddSafeAreaModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.safeAreaInset(edge: .top) {
            Spacer().frame(height: 44)
        }
    }
}
