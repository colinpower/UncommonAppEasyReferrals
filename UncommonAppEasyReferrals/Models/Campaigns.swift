//
//  Campaign.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Campaigns: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var _STATUS: String
    var commission: Struct_Commission
    var color: [Int]
    var offer: Struct_Offer
    var requirements: Campaigns_Requirements
    var timestamp: Campaigns_Timestamp
    var title: String
    var uuid: Campaigns_UUID

    enum CodingKeys: String, CodingKey {
        case _STATUS
        case commission
        case color
        case offer
        case requirements
        case timestamp
        case title
        case uuid
    }
}

struct Campaigns_Requirements: Codable, Hashable {
    
    var customers_only: Bool
    var referral_count: Int
    var users: [String]

    enum CodingKeys: String, CodingKey {
        case customers_only
        case referral_count
        case users
    }
}

struct Campaigns_Timestamp: Codable, Hashable {
    
    var created: Int
    var expires: Int
    var starts: Int

    enum CodingKeys: String, CodingKey {
        case created
        case expires
        case starts
    }
}

struct Campaigns_UUID: Codable, Hashable {
    
    var campaign: String
    var shop: String

    enum CodingKeys: String, CodingKey {
        case campaign
        case shop
    }
}
