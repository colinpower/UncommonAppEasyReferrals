//
//  Memberships.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Membership: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var campaigns: [String]
    var default_campaign: Membership_DefaultCampaign
    var shop: Membership_Shop
    var status: String
    var timestamp: Membership_Timestamp
    var uuid: Membership_UUID
    
    enum CodingKeys: String, CodingKey {
        case campaigns
        case default_campaign
        case shop
        case status
        case timestamp
        case uuid
    }
}

struct Membership_DefaultCampaign: Codable, Hashable {

    var commission: String
    var default_code_uuid: String
    var offer: String
    var isCash: Bool
    var uuid: String

    enum CodingKeys: String, CodingKey {
        case commission
        case default_code_uuid
        case offer
        case isCash
        case uuid
    }
}

struct Membership_Shop: Codable, Hashable {
    
    var customer_id: String
    var domain: String
    var icon: String
    var name: String
    var website: String

    enum CodingKeys: String, CodingKey {
        case customer_id
        case domain
        case icon
        case name
        case website
    }
}

struct Membership_Timestamp: Codable, Hashable {
    
    var created: Int
    var disabled: Int

    enum CodingKeys: String, CodingKey {
        case created
        case disabled
    }
}

struct Membership_UUID: Codable, Hashable {
    
    var membership: String
    var shop: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case membership
        case shop
        case user
    }
}
