//
//  Memberships.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Memberships: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var company_name: String
    var doc_id: String
    var ids: Memberships_Ids
    var primary_campaign: Memberships_PrimaryCampaign
    var stats: Memberships_Stats
    var status: String
    var timestamps: Memberships_Timestamps

    enum CodingKeys: String, CodingKey {
        case company_name
        case doc_id
        case ids
        case primary_campaign
        case stats
        case status
        case timestamps
    }
}

struct Memberships_Ids: Codable, Hashable {
    
    var campaigns: [String]
    var company: String
    var domain: String
    var shopify_customer: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case campaigns
        case company
        case domain
        case shopify_customer
        case user
    }
}

struct Memberships_PrimaryCampaign: Codable, Hashable {

    var commission: Memberships_PrimaryCampaign_Commission
    var linked_code: String
    var offer: Memberships_PrimaryCampaign_Offer
    var primary_campaign_id: String
    var type: String

    enum CodingKeys: String, CodingKey {
        case commission
        case linked_code
        case offer
        case primary_campaign_id
        case type
    }
}

struct Memberships_PrimaryCampaign_Commission: Codable, Hashable {
    
    var category: String
    var type: String
    var value: String

    enum CodingKeys: String, CodingKey {
        case category
        case type
        case value
    }
}

struct Memberships_PrimaryCampaign_Offer: Codable, Hashable {
    
    var category: String
    var type: String
    var value: String

    enum CodingKeys: String, CodingKey {
        case category
        case type
        case value
    }
}

struct Memberships_Stats: Codable, Hashable {
    
    var total_cash: Int
    var total_discounts: Int
    var total_orders: Int
    var total_referrals: Int
    var total_sales: Int

    enum CodingKeys: String, CodingKey {
        case total_cash
        case total_discounts
        case total_orders
        case total_referrals
        case total_sales
    }
}

struct Memberships_Timestamps: Codable, Hashable {
    
    var joined: Int

    enum CodingKeys: String, CodingKey {
        case joined
    }
}
