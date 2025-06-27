import SwiftUI

struct TopBar<Content>: View where Content: View {
    var title: String
    var onBackClick: (() -> Void)?
    var showBackButton: Bool
    let content: () -> Content

    init(
        title: String = "",
        showBackButton: Bool = false,
        onBackClick: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content = { EmptyView() }
    ) {
        self.title = title
        self.onBackClick = onBackClick
        self.showBackButton = showBackButton
        self.content = content
    }

    var body: some View {
        HStack(spacing: 0) {
            if showBackButton {
                DefaultIconButton(
                    "backButton",
                    size: 28,
                    onClick: { onBackClick?() }
                )
            } else {
                Spacer().frame(width: 28)
            }
            Text(String.resource(title))
                .foregroundColor(.black)
                .font(.bold20)
                .lineLimit(1)
            Spacer()
            content()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(.mainOrange)
    }
}
