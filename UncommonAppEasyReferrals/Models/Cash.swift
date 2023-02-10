//
//  Cash.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/20/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Cash: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var _PURPOSE: String
    var shop: Struct_Shop
    var status: String
    var timestamp: Cash_Timestamp
    var uuid: Struct_UUID
    var value: String

    enum CodingKeys: String, CodingKey {
        case _PURPOSE
        case shop
        case status
        case timestamp
        case uuid
        case value
    }
}



struct Cash_Timestamp: Codable, Hashable {

    var created: Int
    var payout: Int
    var transfer: Int
    
    enum CodingKeys: String, CodingKey {
        case created
        case payout
        case transfer
        
    }
}

