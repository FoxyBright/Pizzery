import Foundation

struct Token {
    let value: String
    let expireTime: Int64

    init(_ value: String = "", expireTime: Int64 = 0) {
        self.expireTime = expireTime
        self.value = value
    }

    var isValid: Bool {
        value.isNotBlank && expireTime >= Date().millis
    }
}
