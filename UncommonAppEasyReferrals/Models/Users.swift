//
//  Users.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift



struct Users: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var profile: Struct_Profile
    var settings: Users_Settings
    var timestamp: Users_Timestamp
    var uuid: Users_UUID

    enum CodingKeys: String, CodingKey {
        case profile
        case settings
        case timestamp
        case uuid
    }
}

struct Users_Settings: Codable, Hashable {

    var has_notifications: Bool
    
    enum CodingKeys: String, CodingKey {
        case has_notifications
    }
}

struct Users_Timestamp: Codable, Hashable {

    var created: Int
    var deleted: Int
    
    enum CodingKeys: String, CodingKey {
        case created
        case deleted
    }
}

struct Users_UUID: Codable, Hashable {

    var user: String
    
    enum CodingKeys: String, CodingKey {
        case user
    }
}

//MARK: ADDITIONAL STRUCTS BELOW ------------
struct AuthResult: Identifiable, Codable {

    @DocumentID var id: String? = UUID().uuidString
    var phone_verified: Bool
    var phone: String
    var timestamp: Int
    var doc_id: String

    enum CodingKeys: String, CodingKey {
        case phone_verified
        case phone
        case timestamp
        case doc_id
    }
}

struct Struct_Profile: Codable, Hashable {

    var email: String
    var email_verified: Bool
    var name: Struct_Profile_Name
    var phone: String
    var phone_verified: Bool
 
    enum CodingKeys: String, CodingKey {
        case email
        case email_verified
        case name
        case phone
        case phone_verified
    }
}

struct Struct_Profile_Name: Codable, Hashable {

    var first: String
    var last: String

    enum CodingKeys: String, CodingKey {
        case first
        case last
    }
}

struct Struct_Shop: Codable, Hashable {

    var category: String
    var contact_support_email: String
    var description: String
    var domain: String
    var name: String
    var website: String
 
    enum CodingKeys: String, CodingKey {
        case category
        case contact_support_email
        case description
        case domain
        case name
        case website
    }
}

struct Struct_UUID: Codable, Hashable {

    var campaign: String
    var cash: String
    var code: String
    var membership: String
    var order: String
    var referral: String
    var reward_code: String
    var shop: String
    var user: String
 
    enum CodingKeys: String, CodingKey {
        case campaign
        case cash
        case code
        case membership
        case order
        case referral
        case reward_code
        case shop
        case user
    }
}

struct Struct_Code: Codable, Hashable {

    var code: String
    var UPPERCASED: String
    var color: [Int]
    var graphql_id: String
    var is_default: Bool
 
    enum CodingKeys: String, CodingKey {
        case code
        case UPPERCASED
        case color
        case graphql_id
        case is_default
    }
}

struct Struct_Commission: Codable, Hashable {

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

struct Struct_Offer: Codable, Hashable {

    var one_per_customer: Bool
    var minimum_spend: Int
    var offer: String
    var type: String
    var timestamp: Struct_Offer_Timestamp
    var total_usage_limit: Int
    var value: String
 
    enum CodingKeys: String, CodingKey {
        case one_per_customer
        case minimum_spend
        case offer
        case type
        case timestamp
        case total_usage_limit
        case value
    }
}

struct Struct_Offer_Timestamp: Codable, Hashable {

    var expires: Int
    var starts: Int

    enum CodingKeys: String, CodingKey {
        case expires
        case starts
    }
}


