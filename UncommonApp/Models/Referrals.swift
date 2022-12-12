//
//  Referrals.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Referrals: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var doc_id: String
    var ids: Referrals_Ids
    var status: String
    var timestamps: Referrals_Timestamps
    var values: Referrals_Values

    enum CodingKeys: String, CodingKey {
        case doc_id
        case ids
        case status
        case timestamps
        case values
    }
}


struct Referrals_Ids: Codable, Hashable {
    
    var campaign: String
    var code: String
    var company: String
    var domain: String
    var order: String
    var reward: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case campaign
        case code
        case company
        case domain
        case order
        case reward
        case user
    }
}

struct Referrals_Timestamps: Codable, Hashable {

    var created: Int
    var return_window: Int
    var returned: Int
    var rewarded: Int

    enum CodingKeys: String, CodingKey {
        case created
        case return_window
        case returned
        case rewarded
    }
}

struct Referrals_Values: Codable, Hashable {
    
    var code: String
    var total_discount: Int
    var total_price: Int

    enum CodingKeys: String, CodingKey {
        case code
        case total_discount
        case total_price
    }
}
