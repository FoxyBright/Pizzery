//
// AvalilableTime.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Доступное время */
public struct AvalilableTime: Codable, Hashable {

    /** например, \"12:00\" */
    public var from: String?
    /** например, \"16:00\" */
    public var to: String?

    public init(from: String? = nil, to: String? = nil) {
        self.from = from
        self.to = to
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case from
        case to
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(from, forKey: .from)
        try container.encodeIfPresent(to, forKey: .to)
    }
}

