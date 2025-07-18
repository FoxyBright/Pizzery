//
// FilterValueGroup.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Количество передаваемых значений:   single   - одно значение;   repeated - несколько значений;   interval - два значения (если нужно передать только нижнюю или верхнюю границу,      то для незадействованной границы интервала передать &#39;-1&#39;).     Обязательно первая граница \&quot;меньше\&quot; второй;   none - без значений;  */
public enum FilterValueGroup: String, Codable, CaseIterable {
    case single = "single"
    case repeated = "repeated"
    case interval = "interval"
    case _none = "none"
}
