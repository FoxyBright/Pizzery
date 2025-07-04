//
// Table.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Table: Codable, Hashable {

    public var id: UUID?
    /** Number of the table. */
    public var number: Int?
    /** Table name specified in the organization settings. */
    public var name: String?
    /** Seating capacity of the table. */
    public var seatingCapacity: Int?
    /** Gets a value that indicates whether new orders can be created on this table. The table can be activated or deactivated via iikoOffice. */
    public var isActive: Bool?
    /** Gets the restaurant section that the table belongs to. If table deleted the section will be null. */
    public var restaurantSection: AnyCodable?

    public init(id: UUID? = nil, number: Int? = nil, name: String? = nil, seatingCapacity: Int? = nil, isActive: Bool? = nil, restaurantSection: AnyCodable? = nil) {
        self.id = id
        self.number = number
        self.name = name
        self.seatingCapacity = seatingCapacity
        self.isActive = isActive
        self.restaurantSection = restaurantSection
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "Id"
        case number = "Number"
        case name = "Name"
        case seatingCapacity = "SeatingCapacity"
        case isActive = "IsActive"
        case restaurantSection = "RestaurantSection"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(seatingCapacity, forKey: .seatingCapacity)
        try container.encodeIfPresent(isActive, forKey: .isActive)
        try container.encodeIfPresent(restaurantSection, forKey: .restaurantSection)
    }
}

