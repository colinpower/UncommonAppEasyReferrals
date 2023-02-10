//
//  CodeUpdates.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/23/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct CodeUpdates: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var code: Struct_Code
    var new_code: String
    var shop: Struct_Shop
    var status: String
    var timestamp: CodeUpdates_Timestamp
    var uuid: String

    enum CodingKeys: String, CodingKey {
        case code
        case new_code
        case shop
        case status
        case timestamp
        case uuid
    }
}

struct CodeUpdates_Timestamp: Codable, Hashable {
    
    var created: Int
    var updated: Int

    enum CodingKeys: String, CodingKey {
        case created
        case updated
    }
}
