//
//  Campaign.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Campaign: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var commission: Campaign_Commission
    var domain: String
    var eligibility: Campaign_Eligibility
    var offer: Campaign_Offer
    var status: String
    var timestamp: Campaign_Timestamp
    var uuid: Campaign_UUID

    enum CodingKeys: String, CodingKey {
        case commission
        case domain
        case eligibility
        case offer
        case status
        case timestamp
        case uuid
    }
}


struct Campaign_Commission: Codable, Hashable {

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

struct Campaign_Eligibility: Codable, Hashable {
    
    var limited_to_customers_only: Bool
    var min_referral_count: Int
    var users: [String]

    enum CodingKeys: String, CodingKey {
        case limited_to_customers_only
        case min_referral_count
        case users
    }
}

struct Campaign_Offer: Codable, Hashable {

    var applies_once_per_customer: Bool
    var duration: Int
    var minimum_spend: Int
    var offer: String
    var starts_at: Int
    var type: String
    var usage_limit: Int
    var value: String
    

    enum CodingKeys: String, CodingKey {
        case applies_once_per_customer
        case duration
        case minimum_spend
        case offer
        case starts_at
        case type
        case usage_limit
        case value
    }
}

struct Campaign_Timestamp: Codable, Hashable {
    
    var created: Int
    var ends_at: Int
    var starts_at: Int

    enum CodingKeys: String, CodingKey {
        case created
        case ends_at
        case starts_at
    }
}

struct Campaign_UUID: Codable, Hashable {
    
    var campaign: String
    var shop: String
    

    enum CodingKeys: String, CodingKey {
        
        case campaign
        case shop
        
    }
}
