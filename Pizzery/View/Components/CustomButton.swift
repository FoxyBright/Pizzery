import SwiftUI

private protocol CustomButton: View {
    var text: String { get }
    var containerColor: Color { get }
    var contentColor: Color { get }
    var leadingIcon: UIImage? { get }
    var trailingIcon: UIImage? { get }
    var iconSize: CGFloat { get }
    var paddings: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var font: Font { get }
    var isLoading: Bool { get }
    var enabled: Bool { get }
    var action: @MainActor () -> Void { get }
}

struct SolidButton: CustomButton {
    let text: String
    let containerColor: Color
    let contentColor: Color
    let leadingIcon: UIImage?
    let trailingIcon: UIImage?
    let iconSize: CGFloat
    let paddings: CGFloat
    let cornerRadius: CGFloat
    let font: Font
    let isLoading: Bool
    let enabled: Bool
    let action: @MainActor () -> Void

    init(
        text: String,
        containerColor: Color = .gray3E3E3E,
        contentColor: Color = .white,
        leadingIcon: UIImage? = nil,
        trailingIcon: UIImage? = nil,
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
                iconView(
                    leadingIcon,
                    tint: contentColor,
                    size: iconSize
                )

                Spacer()

                buttonContent(
                    text,
                    font: font,
                    color: contentColor,
                    isLoading: isLoading
                )

                Spacer()

                iconView(
                    trailingIcon,
                    tint: contentColor,
                    size: iconSize
                )
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

struct OutlinedButton: CustomButton {
    let text: String
    let containerColor: Color
    let contentColor: Color
    let leadingIcon: UIImage?
    let trailingIcon: UIImage?
    let iconSize: CGFloat
    let paddings: CGFloat
    let cornerRadius: CGFloat
    let font: Font
    let isLoading: Bool
    let enabled: Bool
    let borderColor: Color
    let borderWidth: CGFloat
    let action: @MainActor () -> Void

    init(
        text: String,
        containerColor: Color = .clear,
        contentColor: Color = .mainOrange,
        leadingIcon: UIImage? = nil,
        trailingIcon: UIImage? = nil,
        iconSize: CGFloat = 16,
        paddings: CGFloat = 22,
        cornerRadius: CGFloat = 10,
        font: Font = .bold14,
        isLoading: Bool = false,
        enabled: Bool = true,
        borderColor: Color = .grayF0F5FA,
        borderWidth: CGFloat = 2,
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
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.action = action
    }

    var body: some View {
        Button(action: { if !isLoading, enabled { action() } }) {
            HStack(alignment: .center, spacing: 10) {
                iconView(
                    leadingIcon,
                    tint: contentColor,
                    size: iconSize
                )

                buttonContent(
                    text,
                    font: font,
                    color: contentColor,
                    isLoading: isLoading
                )

                iconView(
                    trailingIcon,
                    tint: contentColor,
                    size: iconSize
                )
            }
            .fillMaxWidth()
            .padding(paddings)
            .foregroundColor(contentColor.opacity(enabled ? 1 : 0.6))
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        borderColor.opacity(enabled ? 1 : 0.6),
                        lineWidth: borderWidth
                    )
                    .background(
                        containerColor.opacity(enabled ? 1 : 0.6)
                    )
            }
            .animation(.easeInOut(duration: 0.1), value: enabled)
            .clip(cornerRadius)
            .frame(minHeight: paddings * 2 + iconSize)
        }
        .buttonStyle(NoDisabledVisualButtonStyle())
        .disabled(!enabled || isLoading)
    }
}

extension CustomButton {

    @ViewBuilder
    fileprivate func iconView(
        _ res: UIImage?,
        tint: Color,
        size: CGFloat
    ) -> some View {
        if let icon = res {
            Image(uiImage: icon)
                .resizable()
                .tint(tint)
                .frame(size)
        } else {
            Spacer().frame(size)
        }
    }

    @ViewBuilder
    fileprivate func buttonContent(
        _ text: String,
        font: Font,
        color: Color,
        isLoading: Bool
    ) -> some View {
        if isLoading {
            ProgressView().progressViewStyle(
                CircularProgressViewStyle(tint: color)
            )
        } else {
            Text(text)
                .font(font, color)
                .multilineTextAlignment(.center)
                .animation(.easeInOut(duration: 0.3), value: text)
        }
    }
}

private struct NoDisabledVisualButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(
                .easeInOut(duration: 0.1),
                value: configuration.isPressed
            )
    }
}
