//
// LoyaltyLvlUpdateRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Обновление уровня лояльности */
public struct LoyaltyLvlUpdateRequest: Codable, Hashable {

    public var name: String
    /** Начиная с какого баланса действует уровень, включая. В копейках */
    public var min: Int64
    /** До какого баланса действует уровень, не включая. В копейках */
    public var max: Int64
    /** Процент кэшбека. В %*10000 */
    public var percent: Int64

    public init(name: String, min: Int64, max: Int64, percent: Int64) {
        self.name = name
        self.min = min
        self.max = max
        self.percent = percent
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case min
        case max
        case percent
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(min, forKey: .min)
        try container.encode(max, forKey: .max)
        try container.encode(percent, forKey: .percent)
    }
}

