//
// DiscountType.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct DiscountType: Codable, Hashable {

    public var id: String?
    /** Name of discount type */
    public var name: String?
    /** Is this item deleted */
    public var deleted: Bool?
    /** Is this item active for current group */
    public var isActive: Bool?
    /** A sign that the discount is added automatically to order */
    public var isAutomatic: Bool?
    /** Can discount be applied to order manually */
    public var canApplyManually: Bool?
    /** Can discount be applied to order by card number */
    public var canApplyByCardNumber: Bool?
    /** Does it need to set discount sum on adding */
    public var discountByFlexibleSum: Bool?
    /** Can discount be applied to order by discount card */
    public var canApplyByDiscountCard: Bool?
    /** Can discount be applied to order items selectively */
    public var canApplySelectively: Bool?

    public init(id: String? = nil, name: String? = nil, deleted: Bool? = nil, isActive: Bool? = nil, isAutomatic: Bool? = nil, canApplyManually: Bool? = nil, canApplyByCardNumber: Bool? = nil, discountByFlexibleSum: Bool? = nil, canApplyByDiscountCard: Bool? = nil, canApplySelectively: Bool? = nil) {
        self.id = id
        self.name = name
        self.deleted = deleted
        self.isActive = isActive
        self.isAutomatic = isAutomatic
        self.canApplyManually = canApplyManually
        self.canApplyByCardNumber = canApplyByCardNumber
        self.discountByFlexibleSum = discountByFlexibleSum
        self.canApplyByDiscountCard = canApplyByDiscountCard
        self.canApplySelectively = canApplySelectively
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "Id"
        case name = "Name"
        case deleted = "Deleted"
        case isActive = "IsActive"
        case isAutomatic = "IsAutomatic"
        case canApplyManually = "CanApplyManually"
        case canApplyByCardNumber = "CanApplyByCardNumber"
        case discountByFlexibleSum = "DiscountByFlexibleSum"
        case canApplyByDiscountCard = "CanApplyByDiscountCard"
        case canApplySelectively = "CanApplySelectively"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(deleted, forKey: .deleted)
        try container.encodeIfPresent(isActive, forKey: .isActive)
        try container.encodeIfPresent(isAutomatic, forKey: .isAutomatic)
        try container.encodeIfPresent(canApplyManually, forKey: .canApplyManually)
        try container.encodeIfPresent(canApplyByCardNumber, forKey: .canApplyByCardNumber)
        try container.encodeIfPresent(discountByFlexibleSum, forKey: .discountByFlexibleSum)
        try container.encodeIfPresent(canApplyByDiscountCard, forKey: .canApplyByDiscountCard)
        try container.encodeIfPresent(canApplySelectively, forKey: .canApplySelectively)
    }
}

