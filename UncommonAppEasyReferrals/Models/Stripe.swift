//
//  Stripe.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/11/23.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Stripe: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var account: Stripe_Account
    var balance: Stripe_Balance
    var info: Stripe_Info
    var timestamp: Stripe_Timestamp
    var uuid: Stripe_UUID

    enum CodingKeys: String, CodingKey {
        case account
        case balance
        case info
        case timestamp
        case uuid
    }
}

struct Stripe_Account: Codable, Hashable {
    
    var id: String
    var link: String
    var charges_enabled: Bool
    var details_submitted: Bool
    var currently_due: [String]
    var eventually_due: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case link
        case charges_enabled
        case details_submitted
        case currently_due
        case eventually_due
    }
}

struct Stripe_Balance: Codable, Hashable {
    
    var pending: Int
    var available: Int
    var stripe: Int

    enum CodingKeys: String, CodingKey {
        case pending
        case available
        case stripe
    }
}

struct Stripe_Info: Codable, Hashable {
    
    var first_name: String
    var last_name: String
    var email: String
    var phone: String

    enum CodingKeys: String, CodingKey {
        case first_name
        case last_name
        case email
        case phone
    }
}

struct Stripe_Timestamp: Codable, Hashable {
    
    var created: Int
    var last_updated: Int

    enum CodingKeys: String, CodingKey {
        case created
        case last_updated
    }
}

struct Stripe_UUID: Codable, Hashable {
    
    var user: String
    var stripe: String
    var last_update: String

    enum CodingKeys: String, CodingKey {
        
        case user
        case stripe
        case last_update
    }
}
