import SwiftUI

struct ClickableText: View {
    var text: () -> AttributedString
    var onClick: (String) -> Void

    var body: some View {
        Text(text()).environment(
            \.openURL,
            OpenURLAction { url in
                onClick(url.absoluteString)
                return .handled
            }
        )
    }
}
