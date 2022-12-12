//
//  Campaigns.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Campaigns: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var commission: Campaigns_Commission
    var doc_id: String
    var ids: Campaigns_Ids
    var offer: Campaigns_Offer
    var settings: Campaigns_Settings

    enum CodingKeys: String, CodingKey {
        case commission
        case doc_id
        case ids
        case offer
        case settings
    }
}


struct Campaigns_Commission: Codable, Hashable {

    var category: String
    var type: String
    var value: String

    enum CodingKeys: String, CodingKey {
        case category
        case type
        case value
    }
}

struct Campaigns_Ids: Codable, Hashable {
    
    var company: String
    var domain: String

    enum CodingKeys: String, CodingKey {
        case company
        case domain
    }
}

struct Campaigns_Offer: Codable, Hashable {

    var appliesOncePerCustomer: Bool
    var category: String
    var ends_at: Int
    var minimum_spend: Int
    var starts_at: Int
    var type: String
    var usage_limit: Int
    var value: String

    enum CodingKeys: String, CodingKey {
        case appliesOncePerCustomer
        case category
        case ends_at
        case minimum_spend
        case starts_at
        case type
        case usage_limit
        case value
    }
}

struct Campaigns_Settings: Codable, Hashable {
    
    var discount_active_for: Int
    var eligibility: Campaigns_Settings_Eligibility
    var return_window: Int
    var type: String

    enum CodingKeys: String, CodingKey {
        case discount_active_for
        case eligibility
        case return_window
        case type
    }
}

struct Campaigns_Settings_Eligibility: Codable, Hashable {
    
    var has_shopped_before: Bool
    var min_referrals: Int
    var users: [String]

    enum CodingKeys: String, CodingKey {
        case has_shopped_before
        case min_referrals
        case users
    }
}
