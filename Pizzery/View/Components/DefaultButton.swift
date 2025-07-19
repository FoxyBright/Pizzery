import SwiftUI

struct DefaultButton: View {
    var text: String
    var containerColor: Color
    var contentColor: Color
    var leadingIcon: String
    var trailingIcon: String
    var iconSize: CGFloat
    var paddings: CGFloat
    var cornerRadius: CGFloat
    var font: Font
    var isLoading: Bool
    var enabled: Bool
    var action: @MainActor () -> Void

    init(
        text: String,
        containerColor: Color = .gray3E3E3E,
        contentColor: Color = .white,
        leadingIcon: String = "",
        trailingIcon: String = "",
        iconSize: CGFloat = 24,
        paddings: CGFloat = 16,
        cornerRadius: CGFloat = 16,
        font: Font = .semibold18,
        isLoading: Bool = false,
        enabled: Bool = true,
        action: @escaping () -> Void = {}
    ) {
        self.text = text
        self.containerColor = containerColor
        self.contentColor = contentColor
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.iconSize = iconSize
        self.paddings = paddings
        self.cornerRadius = cornerRadius
        self.font = font
        self.isLoading = isLoading
        self.enabled = enabled
        self.action = action
    }

    var body: some View {
        Button(action: { if !isLoading, enabled { action() } }) {
            HStack(alignment: .center, spacing: 12) {
                iconView(leadingIcon)

                Spacer()

                buttonContent()

                Spacer()

                iconView(trailingIcon)
            }
            .fillMaxWidth()
            .padding(paddings)
            .foregroundColor(contentColor.opacity(enabled ? 1 : 0.6))
            .background(containerColor.opacity(enabled ? 1 : 0.6))
            .animation(.easeInOut(duration: 0.1), value: enabled)
            .clip(cornerRadius)
            .frame(minHeight: paddings * 2 + iconSize)
        }
        .buttonStyle(NoDisabledVisualButtonStyle())
        .disabled(!enabled || isLoading)
    }
}

extension DefaultButton {

    @ViewBuilder
    func iconView(_ icon: String) -> some View {
        if icon.isNotEmpty {
            Image(icon)
                .resizable()
                .tint(contentColor)
                .frame(iconSize)
        } else {
            Spacer().frame(iconSize)
        }
    }

    @ViewBuilder
    func buttonContent() -> some View {
        if isLoading {
            ProgressView().progressViewStyle(
                CircularProgressViewStyle(tint: contentColor)
            )
        } else {
            Text(text)
                .font(font, contentColor)
                .multilineTextAlignment(.center)
                .animation(.easeInOut(duration: 0.3), value: text)
        }
    }
}
