//
// PosterListRequestFilterInner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct PosterListRequestFilterInner: Codable, Hashable {

    public enum FilterParameter: String, Codable, CaseIterable {
        case outletId = "outlet_id"
        case partnerId = "partner_id"
        case startDate = "start_date"
        case finishDate = "finish_date"
    }
    /** Параметр, по которому осуществляется фильтрация.   start_date - фильтрация по дате начала value_type: int64, value_group: single, repeated;   finish_date - фильтрация по дате окончания value_type: int64, value_group: single, repeated;   partner_id - фильтрация по партнеру value_type: int64, value_group: single, repeated;   outlet_id - фильтрация по ресторану value_type: int64, value_group: single, repeated;  */
    public var filterParameter: FilterParameter
    public var inputValue: [FilterInputValueInner]?
    public var valueGroup: FilterValueGroup
    public var filterType: FilterType

    public init(filterParameter: FilterParameter, inputValue: [FilterInputValueInner]? = nil, valueGroup: FilterValueGroup, filterType: FilterType) {
        self.filterParameter = filterParameter
        self.inputValue = inputValue
        self.valueGroup = valueGroup
        self.filterType = filterType
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case filterParameter = "filter_parameter"
        case inputValue = "input_value"
        case valueGroup = "value_group"
        case filterType = "filter_type"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filterParameter, forKey: .filterParameter)
        try container.encodeIfPresent(inputValue, forKey: .inputValue)
        try container.encode(valueGroup, forKey: .valueGroup)
        try container.encode(filterType, forKey: .filterType)
    }
}

