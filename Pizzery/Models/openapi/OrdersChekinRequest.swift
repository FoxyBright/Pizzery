//
// OrdersChekinRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct OrdersChekinRequest: Codable, Hashable {

    public var value: String?
    public var waiterPin: String
    /** Флаг при успешном чекине, при false отправляет просто инфа о клиенте */
    public var success: Bool?
    /** Total sum to be paid, sum of all not deleted order items with discounts and both included and excluded vat. */
    public var resultSum: Double?

    public init(value: String? = nil, waiterPin: String, success: Bool? = nil, resultSum: Double? = nil) {
        self.value = value
        self.waiterPin = waiterPin
        self.success = success
        self.resultSum = resultSum
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case value = "Value"
        case waiterPin = "WaiterPin"
        case success
        case resultSum = "ResultSum"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(value, forKey: .value)
        try container.encode(waiterPin, forKey: .waiterPin)
        try container.encodeIfPresent(success, forKey: .success)
        try container.encodeIfPresent(resultSum, forKey: .resultSum)
    }
}

