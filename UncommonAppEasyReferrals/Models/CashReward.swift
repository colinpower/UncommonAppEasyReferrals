//
//  CashReward.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct CashReward: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var shop: CashReward_Shop
    var status: String
    var timestamp: CashReward_Timestamp
    var uuid: CashReward_UUID
    var value: String

    enum CodingKeys: String, CodingKey {
        case shop
        case status
        case timestamp
        case uuid
        case value
    }
}

struct CashReward_Shop: Codable, Hashable {

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

struct CashReward_Timestamp: Codable, Hashable {

    var created: Int
    var transferred: Int
    
    enum CodingKeys: String, CodingKey {
        case created
        case transferred
    }
}

struct CashReward_UUID: Codable, Hashable {
    
    var campaign: String
    var cash_reward: String
    var code: String
    var membership: String
    var order: String
    var referral: String
    var shop: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case campaign
        case cash_reward
        case code
        case membership
        case order
        case referral
        case shop
        case user
    }
}
