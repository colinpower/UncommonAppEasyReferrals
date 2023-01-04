//
//  Shop.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Shop: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var account: Shop_Account
    var campaigns: [String]
    var info: Shop_Info
    var timestamp: Shop_Timestamp
    var uuid: Shop_UUID

    enum CodingKeys: String, CodingKey {
        case account
        case campaigns
        case info
        case timestamp
        case uuid
    }
}


struct Shop_Account: Codable, Hashable {

    var email: String
    var name: Shop_Name

    enum CodingKeys: String, CodingKey {
        case email
        case name
    }
}

struct Shop_Name: Codable, Hashable {

    var first: String
    var last: String

    enum CodingKeys: String, CodingKey {
        case first
        case last
    }
}

struct Shop_Info: Codable, Hashable {

    var category: String
    var description: String
    var domain: String
    var icon: String
    var name: String
    var website: String

    enum CodingKeys: String, CodingKey {
        case category
        case description
        case domain
        case icon
        case name
        case website
    }
}

struct Shop_Timestamp: Codable, Hashable {
    
    var created: Int

    enum CodingKeys: String, CodingKey {
        case created
    }
}

struct Shop_UUID: Codable, Hashable {
    
    var shop: String

    enum CodingKeys: String, CodingKey {
        case shop
    }
}
