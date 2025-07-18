//
// AdminPartnerListRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct AdminPartnerListRequest: Codable, Hashable {

    public var pagination: Pagination

    public init(pagination: Pagination) {
        self.pagination = pagination
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case pagination
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pagination, forKey: .pagination)
    }
}

