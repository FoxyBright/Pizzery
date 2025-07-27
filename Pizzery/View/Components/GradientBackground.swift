import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .white, .grayF4F0F0, .grayCBCBCB
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
