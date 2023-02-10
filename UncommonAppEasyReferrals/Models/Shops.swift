//
//  Shop.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Shops: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var _STATUS: String
    var profile: Struct_Profile
    var campaigns: [String]
    var shop: Struct_Shop
    var timestamp: Shops_Timestamp
    var uuid: Shops_UUID

    enum CodingKeys: String, CodingKey {
        case _STATUS
        case profile
        case campaigns
        case shop
        case timestamp
        case uuid
    }
}

struct Shops_Timestamp: Codable, Hashable {
    
    var created: Int
    var deleted: Int

    enum CodingKeys: String, CodingKey {
        case created
        case deleted
    }
}

struct Shops_UUID: Codable, Hashable {
    
    var shop: String

    enum CodingKeys: String, CodingKey {
        case shop
    }
}
