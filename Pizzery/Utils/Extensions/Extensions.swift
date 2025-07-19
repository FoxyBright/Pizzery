import SwiftUI

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}

extension String {
    var isNotEmpty: Bool { !self.isEmpty }

    func ifEmpty(_ defaultValue: () -> String) -> String {
        self.isEmpty ? defaultValue() : self
    }

    func applyMask(_ mask: String, changedChar: Character) -> String {
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

    func ifEmpty(_ defaultValue: () -> Array) -> Array {
        self.isEmpty ? defaultValue() : self
    }
}
