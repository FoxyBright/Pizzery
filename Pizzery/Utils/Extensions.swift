import Combine
import Foundation
import SwiftUI

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

extension Date {
    var millis: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(_ millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis) / 1000)
    }

    init(day: Int, month: Int, year: Int) {
        var components = DateComponents()
        let calendar = Calendar.current
        components.day = day
        components.month = month
        components.year = year
        self = calendar.date(from: components)!
    }

    init(
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        millisecond: Int = 0,
        nanosecond: Int = 0
    ) {
        var components = Calendar.current
            .dateComponents([.year, .month, .day], from: Date())
        components.hour = hour
        components.minute = minute
        components.second = second
        components.nanosecond = nanosecond + millisecond * 1_000_000

        self = Calendar.current.date(from: components)!
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
