//
// PartnerClientListRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct PartnerClientListRequest: Codable, Hashable {

    /** Фильтрация по параметрам */
    public var filter: [PartnerClientListRequestFilterInner]?
    public var sort: PartnerClientListRequestSort?
    /** Поиск по параметрам */
    public var search: [PartnerClientListRequestSearchInner]?
    public var pagination: Pagination

    public init(filter: [PartnerClientListRequestFilterInner]? = nil, sort: PartnerClientListRequestSort? = nil, search: [PartnerClientListRequestSearchInner]? = nil, pagination: Pagination) {
        self.filter = filter
        self.sort = sort
        self.search = search
        self.pagination = pagination
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case filter
        case sort
        case search
        case pagination
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(filter, forKey: .filter)
        try container.encodeIfPresent(sort, forKey: .sort)
        try container.encodeIfPresent(search, forKey: .search)
        try container.encode(pagination, forKey: .pagination)
    }
}

