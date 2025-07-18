//
// BonusTransactionReason.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** Причина транзакции */
public enum BonusTransactionReason: String, Codable, CaseIterable {
    case manual = "manual"
    case order = "order"
    case system = "system"
}
