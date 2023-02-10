//
//  Codes.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/20/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Codes: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var _PURPOSE: String
    var code: Struct_Code
    var shop: Struct_Shop
    var stats: Codes_Stats
    var status: String
    var timestamp: Codes_Timestamp
    var uuid: Struct_UUID

    enum CodingKeys: String, CodingKey {
        case _PURPOSE
        case code
        case shop
        case stats
        case status
        case timestamp
        case uuid
    }
}

struct Codes_Stats: Codable, Hashable {

    var usage_count: Int
    var usage_limit: Int
    
    enum CodingKeys: String, CodingKey {
        case usage_count
        case usage_limit
    }
}

struct Codes_Timestamp: Codable, Hashable {

    var created: Int
    var deleted: Int
    var last_used: Int
    var pending: Int
    
    enum CodingKeys: String, CodingKey {
        case created
        case deleted
        case last_used
        case pending
        
    }
}
