//
//  Rewards.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Rewards: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var doc_id: String
    var ids: Rewards_Ids
    var status: String
    var timestamps: Rewards_Timestamps
    var type: String

    enum CodingKeys: String, CodingKey {
        case doc_id
        case ids
        case status
        case timestamps
        case type
    }
}

struct Rewards_Ids: Codable, Hashable {
    
    var campaign: String
    var code: String
    var company: String
    var domain: String
    var membership: String
    var referral: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case campaign
        case code
        case company
        case domain
        case membership
        case referral
        case user
    }
}

struct Rewards_Timestamps: Codable, Hashable {

    var created: Int
    var used: Int
    
    enum CodingKeys: String, CodingKey {
        case created
        case used
    }
}
