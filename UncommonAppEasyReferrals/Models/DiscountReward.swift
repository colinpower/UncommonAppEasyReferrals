//
//  Rewards.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct DiscountReward: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var code: DiscountReward_Code
    var shop: DiscountReward_Shop
    var status: String
    var timestamp: DiscountReward_Timestamp
    var uuid: DiscountReward_UUID
    
    enum CodingKeys: String, CodingKey {
        case code
        case shop
        case status
        case timestamp
        case uuid
    }
}


struct DiscountReward_Code: Codable, Hashable {
    
    var code: String
    var duration: Int
    var graphql_id: String
    var minimum_spend: Int
    var starts_at: Int
    var type: String
    var usage_limit: Int
    var value: String

    enum CodingKeys: String, CodingKey {
        case code
        case duration
        case graphql_id
        case minimum_spend
        case starts_at
        case type
        case usage_limit
        case value
    }
}

struct DiscountReward_Shop: Codable, Hashable {

    var domain: String
    var icon: String
    var name: String
    var website: String

    enum CodingKeys: String, CodingKey {
        case domain
        case icon
        case name
        case website
    }
}

struct DiscountReward_Timestamp: Codable, Hashable {

    var created: Int
    var deleted: Int
    var expired: Int
    var returned: Int
    var used: Int
    
    enum CodingKeys: String, CodingKey {
        case created
        case deleted
        case expired
        case returned
        case used
    }
}

struct DiscountReward_UUID: Codable, Hashable {
    
    var campaign: String
    var code: String
    var discount_reward: String
    var membership: String
    var order: String
    var referral: String
    var shop: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case campaign
        case code
        case discount_reward
        case membership
        case order
        case referral
        case shop
        case user
    }
}
