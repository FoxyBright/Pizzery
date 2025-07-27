import SwiftUI

struct TopBar<Content>: View where Content: View {
    let title: String
    let onBackClick: (@MainActor () -> Void)?
    let showBackButton: Bool
    let content: () -> Content

    init(
        title: String = "",
        showBackButton: Bool = false,
        onBackClick: (@MainActor () -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content = { EmptyView() }
    ) {
        self.title = title
        self.onBackClick = onBackClick
        self.showBackButton = showBackButton
        self.content = content
    }

    var body: some View {
        HStack(spacing: 0) {
            backButton(show: showBackButton) {
                onBackClick?()
            }

            Text(title)
                .font(.bold20, .black)
                .lineLimit(1)

            Spacer()

            content()
        }
        .fillMaxWidth(alignment: .leading)
        .padding(horizontal: 16)
        .padding(bottom: 16)
        .background(.mainOrange)
    }
}

extension View {

    @ViewBuilder
    func backButton(
        show: Bool = false,
        onBackClick: @escaping (() -> Void) = {}
    ) -> some View {
        if show {
            Button(action: onBackClick) {
                Image(.backButton)
                    .resizable()
                    .tint(.gray3E3E3E)
                    .frame(28)
            }
        } else {
            Spacer().frame(width: 28)
        }
    }
}
