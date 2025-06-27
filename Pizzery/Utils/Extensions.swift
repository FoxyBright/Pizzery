import Foundation
import SwiftUI
import Combine

extension View {
    @ViewBuilder
    func debugBorder() -> some View {
        #if DEBUG
            self.border(Color.random())
        #else
            self
        #endif
    }

    func addSafeArea() -> some View {
        modifier(AddSafeAreaModifier())
    }
}

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}

extension String {
    static func resource(_ id: String, comment: String = "") -> String {
        NSLocalizedString(id, comment: comment)
    }
    
    static func resource(_ key: StringResources, comment: String = "") -> String {
        NSLocalizedString(key.rawValue, comment: comment)
    }

    var isNotEmpty: Bool { !self.isEmpty }

    var isNotBlank: Bool {
        self.filter { !$0.isWhitespace }.isNotEmpty
    }
    
    func applyMask(
        _ mask: String,
        changedChar: Character
    ) -> String {
        var result = ""
        var index = self.startIndex
        for ch in mask {
            guard index < self.endIndex else {
                break
            }
            if ch == changedChar {
                result.append(self[index])
                index = self.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

extension Array where Element: Equatable {
    var isNotEmpty: Bool { !self.isEmpty }
}

extension Date {
    var millis: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(_ millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis) / 1000)
    }

    func format(
        _ pattern: String,
        locale: Locale = Locale.current
    ) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = pattern
        return formatter.string(from: self)
    }
}
