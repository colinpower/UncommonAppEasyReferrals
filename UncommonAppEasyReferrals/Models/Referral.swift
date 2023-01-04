//
//  Referrals.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Referral: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var commission: Referral_Commission
    var offer: String
    var revenue: String
    var status: String
    var timestamp: Referral_Timestamp
    var uuid: Referral_UUID

    enum CodingKeys: String, CodingKey {
        case commission
        case offer
        case revenue
        case status
        case timestamp
        case uuid
    }
}


struct Referral_Commission: Codable, Hashable {

    var duration_pending: Int
    var offer: String
    var type: String
    var value: String

    enum CodingKeys: String, CodingKey {
        
        case duration_pending
        case offer
        case type
        case value
    }
}

struct Referral_Timestamp: Codable, Hashable {

    var completed: Int
    var created: Int
    var deleted: Int
    var flagged: Int
    var returned: Int

    enum CodingKeys: String, CodingKey {
        case completed
        case created
        case deleted
        case flagged
        case returned
    }
}

struct Referral_UUID: Codable, Hashable {
    
    var campaign: String
    var cash_reward: String
    var code: String
    var discount_reward: String
    var membership: String
    var order: String
    var referral: String
    var shop: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case campaign
        case cash_reward
        case code
        case discount_reward
        case membership
        case order
        case referral
        case shop
        case user
    }
}


