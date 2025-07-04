//
// LoyaltyLvlPictureDeleteRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct LoyaltyLvlPictureDeleteRequest: Codable, Hashable {

    /** урл картинки */
    public var picture: String?

    public init(picture: String? = nil) {
        self.picture = picture
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case picture
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(picture, forKey: .picture)
    }
}

