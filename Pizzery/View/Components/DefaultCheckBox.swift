import SwiftUI

struct DefaultCheckBox: View {
    var isSelected: Bool
    var size: CGFloat = 24
    var onSwitch: @MainActor (Bool) -> Void = { _ in }

    var body: some View {
        Button(action: { onSwitch(!isSelected) }) {
            Circle()
                .frame(size)
                .foregroundColor(isSelected ? .mainOrange : .clear)
                .overlay {
                    if isSelected {
                        Image(.check)
                            .resizable()
                            .fillMaxSize()
                            .tint(isSelected ? .white : .clear)
                            .padding(2)

                    } else {
                        Circle().strokeBorder(
                            !isSelected ? .gray94A3B3 : .clear,
                            lineWidth: 2
                        )
                    }
                }
        }
    }
}
