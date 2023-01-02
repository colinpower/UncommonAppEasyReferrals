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
    var account: Users_Account
    var doc_id: String
    var profile: Users_Profile
    var settings: Users_Settings
    var timestamps: Users_Timestamps


    enum CodingKeys: String, CodingKey {
        case account
        case doc_id
        case profile
        case settings
        case timestamps
    }
}

struct Users_Account: Codable, Hashable {
    
    var available_cash: Double
    var available_discounts: Int

    enum CodingKeys: String, CodingKey {
        case available_cash
        case available_discounts
    }
}

struct Users_Profile: Codable, Hashable {
    
    var email: String
    var first_name: String
    var last_name: String
    var phone: String
    var phone_verified: Bool

    enum CodingKeys: String, CodingKey {
        case email
        case first_name
        case last_name
        case phone
        case phone_verified
    }
}

struct Users_Settings: Codable, Hashable {

    var notifications: Bool
    
    enum CodingKeys: String, CodingKey {
        case notifications
    }
}

struct Users_Timestamps: Codable, Hashable {

    var joined: Int
    
    enum CodingKeys: String, CodingKey {
        case joined
    }
}



struct AuthResult: Identifiable, Codable {
    //means that whenever we map from a doc into a User struct, it'll read the document and map it into this thing
    @DocumentID var id: String? = UUID().uuidString
    var phone_verified: Bool
    var phone: String
    var timestamp: Int
    var doc_id: String

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {
        case phone_verified
        case phone
        case timestamp
        case doc_id
    }
}
