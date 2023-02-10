//
//  Stripe_Accounts.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/20/23.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Stripe_Accounts: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var account: Stripe_Accounts_Account
    var profile: Struct_Profile
    var setup: Stripe_Accounts_Setup
    var timestamp: Stripe_Accounts_Timestamp
    var uuid: Stripe_Accounts_UUID

    enum CodingKeys: String, CodingKey {
        case account
        case profile
        case setup
        case timestamp
        case uuid
    }
}

struct Stripe_Accounts_Account: Codable, Hashable {

    var acct_id: String
    var balance: Int
    var link: Stripe_Accounts_Account_Link
    var methods_available: [String]
    var source_type: String
    
    enum CodingKeys: String, CodingKey {
        case acct_id
        case balance
        case link
        case methods_available
        case source_type
    }
}


struct Stripe_Accounts_Account_Link: Codable, Hashable {

    var created: Int
    var object: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case created
        case object
        case url
    }
}

struct Stripe_Accounts_Setup: Codable, Hashable {

    var charges_enabled: Bool
    var currently_due: [String]
    var details_submitted: Bool
    var eventually_due: [String]
    var link: String
    
    enum CodingKeys: String, CodingKey {
        case charges_enabled
        case currently_due
        case details_submitted
        case eventually_due
        case link
    }
}

struct Stripe_Accounts_Timestamp: Codable, Hashable {

    var created: Int
    var last_updated: Int
    
    enum CodingKeys: String, CodingKey {
        case created
        case last_updated
        
    }
}

struct Stripe_Accounts_UUID: Codable, Hashable {

    var stripe_account: String
    var user: String
    
    enum CodingKeys: String, CodingKey {
        case stripe_account
        case user
        
    }
}
