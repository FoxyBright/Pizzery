import SwiftUI

struct DefaultButton: View {
    var text: String
    var containerColor: Color = .gray3E3E3E
    var contentColor: Color = .white
    var leadingIcon: String = ""
    var trailingIcon: String = ""
    var iconSize: CGFloat = 24
    var paddings: CGFloat = 16
    var cornerRadius: CGFloat = 16
    var font: Font = .semibold18
    var isLoading: Bool = false
    var enabled: Bool = true
    var action: (@MainActor () -> Void)?

    var body: some View {
        Button(action: { if !isLoading, enabled { action?() } }) {
            HStack(alignment: .center, spacing: 12) {
                IconView(
                    icon: leadingIcon,
                    size: iconSize,
                    tint: contentColor
                )
                Spacer()
                if isLoading {
                    ProgressView().progressViewStyle(
                        CircularProgressViewStyle(tint: contentColor)
                    )
                } else {
                    Text(text)
                        .font(font)
                        .foregroundColor(contentColor)
                        .multilineTextAlignment(.center)
                        .animation(.easeInOut(duration: 0.3), value: text)
                }
                Spacer()
                IconView(
                    icon: trailingIcon,
                    size: iconSize,
                    tint: contentColor
                )
            }
            .frame(maxWidth: .infinity)
            .padding(paddings)
            .foregroundColor(contentColor.opacity(enabled ? 1 : 0.6))
            .background(containerColor.opacity(enabled ? 1 : 0.6))
            .animation(.easeInOut(duration: 0.1), value: enabled)
            .clipped()
            .cornerRadius(cornerRadius)
            .frame(minHeight: paddings * 2 + iconSize)
        }
        .buttonStyle(NoDisabledVisualButtonStyle())
        .disabled(!enabled || isLoading)
    }
}

private struct IconView: View {
    var icon: String, size: CGFloat, tint: Color
    
    var body: some View {
        if icon.isNotEmpty {
            Image(icon)
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(tint)
        } else {
            Color.clear
                .frame(width: size, height: size)
                .hidden()
        }
    }
}

private struct NoDisabledVisualButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
