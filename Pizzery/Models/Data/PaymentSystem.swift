enum PaymentSystem: String {
    case visa, masterCard, mir, amex, unionPay, jcb, maestro, unknown

    static func getByCardNumber(_ number: String) -> PaymentSystem {
        let cleaned = number.filter(\.isNumber)
        guard cleaned.count >= 6 else { return .unknown }

        switch true {
        case cleaned.hasPrefix("4"):
            return .visa
        case (51...55).contains(Int(String(cleaned.prefix(2))) ?? 0),
            (2221...2720).contains(Int(String(cleaned.prefix(4))) ?? 0):
            return .masterCard
        case (2200...2204).contains(Int(String(cleaned.prefix(4))) ?? 0):
            return .mir
        case cleaned.hasPrefix("34") || cleaned.hasPrefix("37"):
            return .amex
        case cleaned.hasPrefix("62"):
            return .unionPay
        case cleaned.hasPrefix("35"):
            return .jcb
        case cleaned.range(
            of: #"^(50|56|57|58|6)"#,
            options: .regularExpression
        ) != nil:
            return .maestro
        default:
            return .unknown
        }
    }
}
