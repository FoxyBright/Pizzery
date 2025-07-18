//
// RefCode.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** реф код */
public struct RefCode: Codable, Hashable {

    public var id: Int64
    public var code: String
    public var note: String
    /** Идентификатор клиента, к которому относится реф код (может отсутствовать) */
    public var clientId: Int64?
    /** количество начисляемых баллов *100 */
    public var pointAmount: Int64
    /** количество рефералов */
    public var countReferrals: Int64
    /** дата создания кода */
    public var createdAt: Int64
    /** заблокирован или нет */
    public var isBlocked: Bool

    public init(id: Int64, code: String, note: String, clientId: Int64? = nil, pointAmount: Int64, countReferrals: Int64, createdAt: Int64, isBlocked: Bool) {
        self.id = id
        self.code = code
        self.note = note
        self.clientId = clientId
        self.pointAmount = pointAmount
        self.countReferrals = countReferrals
        self.createdAt = createdAt
        self.isBlocked = isBlocked
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case code
        case note
        case clientId = "client_id"
        case pointAmount = "point_amount"
        case countReferrals = "count_referrals"
        case createdAt = "created_at"
        case isBlocked = "is_blocked"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(code, forKey: .code)
        try container.encode(note, forKey: .note)
        try container.encodeIfPresent(clientId, forKey: .clientId)
        try container.encode(pointAmount, forKey: .pointAmount)
        try container.encode(countReferrals, forKey: .countReferrals)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(isBlocked, forKey: .isBlocked)
    }
}


@available(iOS 13, tvOS 13, watchOS 6, macOS 10.15, *)
extension RefCode: Identifiable {}
