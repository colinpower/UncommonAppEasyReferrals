//
//  Codes.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Code: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var code: Code_Code
    var shop: Code_Shop
    var stats: Code_Stats
    var status: Code_Status
    var timestamp: Code_Timestamp
    var uuid: Code_UUID

    enum CodingKeys: String, CodingKey {
        case code
        case shop
        case stats
        case status
        case timestamp
        case uuid
    }
}

struct Code_Code: Codable, Hashable {
    
    var code: String
    var color: [Int]
    var graphql_id: String
    var is_default: Bool

    enum CodingKeys: String, CodingKey {
        case code
        case color
        case graphql_id
        case is_default
    }
}

struct Code_Shop: Codable, Hashable {
    
    var domain: String
    var name: String
    var website: String

    enum CodingKeys: String, CodingKey {
        case domain
        case name
        case website
    }
}

struct Code_Stats: Codable, Hashable {
    
    var usage_count: Int
    var usage_limit: Int

    enum CodingKeys: String, CodingKey {
        case usage_count
        case usage_limit
    }
}

struct Code_Status: Codable, Hashable {
    
    var did_creation_succeed: Bool
    var status: String

    enum CodingKeys: String, CodingKey {
        case did_creation_succeed
        case status
    }
}

struct Code_Timestamp: Codable, Hashable {
    
    var created: Int
    var deleted: Int
    var used: Int

    enum CodingKeys: String, CodingKey {
        case created
        case deleted
        case used
    }
}

struct Code_UUID: Codable, Hashable {
    
    var campaign: String
    var code: String
    var membership: String
    var shop: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case campaign
        case code
        case membership
        case shop
        case user
    }
}
