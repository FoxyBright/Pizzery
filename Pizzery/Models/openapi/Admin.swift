//
// Admin.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Админ */
public struct Admin: Codable, Hashable {

    public var id: Int64?
    public var login: String?

    public init(id: Int64? = nil, login: String? = nil) {
        self.id = id
        self.login = login
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case login
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(login, forKey: .login)
    }
}


@available(iOS 13, tvOS 13, watchOS 6, macOS 10.15, *)
extension Admin: Identifiable {}
