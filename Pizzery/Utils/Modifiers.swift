import SwiftUI

struct AddSafeAreaModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.safeAreaInset(edge: .top) {
            Color.clear.frame(height: 44)
        }
    }
}
