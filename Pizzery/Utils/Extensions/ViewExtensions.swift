import SwiftUI

extension View {
    func font<S: ShapeStyle>(_ font: Font, _ style: S) -> some View {
        self.font(font).foregroundStyle(style)
    }

    func padding(
        top: CGFloat = 0,
        start: CGFloat = 0,
        bottom: CGFloat = 0,
        end: CGFloat = 0
    ) -> some View {
        self.padding(
            EdgeInsets(
                top: top,
                leading: start,
                bottom: bottom,
                trailing: end
            )
        )
    }

    func padding(
        horizontal: CGFloat = 0,
        vertical: CGFloat = 0
    ) -> some View {
        self.padding(
            top: vertical,
            start: horizontal,
            bottom: vertical,
            end: horizontal
        )
    }

    func fillMaxSize(alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }

    func fillMaxWidth(alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }

    func fillMaxHeight(alignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }

    func addSafeArea() -> some View {
        modifier(AddSafeAreaModifier())
    }
    
    func debugBorder() -> some View {
        #if DEBUG
            self.border(Color.random())
        #else
            self
        #endif
    }

    @ViewBuilder
    func frame(_ size: CGFloat?, alignment: Alignment = .center) -> some View {
        if let size = size, size.isFinite, size >= 0 {
            self.frame(width: size, height: size, alignment: alignment)
        } else {
            self
        }
    }

    @ViewBuilder
    func clip(
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners,
        clip: Bool = false
    ) -> some View {
        let view = self.clipShape(
            RoundedCorners(radius: radius, corners: corners)
        )
        if clip { view.clipped() } else { view }
    }
}

extension Image {
    func tint<S: ShapeStyle>(_ style: S) -> some View {
        self.renderingMode(.template).foregroundStyle(style)
    }
}
