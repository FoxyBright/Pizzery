import SwiftUI

struct DefaultIconButton: View {
    var image: String
    var size: CGFloat
    var containerColor: Color?
    var contentColor: Color?
    var onClick: (@MainActor () -> Void)

    init(
        _ image: String,
        size: CGFloat = 34,
        containerColor: Color? = nil,
        contentColor: Color = .black,
        onClick: @escaping @MainActor () -> Void = {}
    ) {
        self.image = image
        self.size = size
        self.containerColor = containerColor
        self.onClick = onClick
    }

    var body: some View {
        Button(action: onClick) {
            Image(image)
                .resizable()
                .background(containerColor)
                .foregroundColor(contentColor)
                .frame(width: size, height: size)
        }
    }
}
