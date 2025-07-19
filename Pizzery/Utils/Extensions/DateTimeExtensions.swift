import Foundation

extension Date {
    var millis: Int64 {
        Int64((self.timeIntervalSince1970 * 1_000.0).rounded())
    }

    init(_ millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis) / 1_000)
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
