//
//  Codes.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Codes: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var code: String
    var doc_id: String
    var ids: Codes_Ids
    var purpose: String
    var status: String
    var type: String
    var usage_count: Int
    var usage_limit: Int

    enum CodingKeys: String, CodingKey {
        case code
        case doc_id
        case ids
        case purpose
        case status
        case type
        case usage_count
        case usage_limit
    }
}

struct Codes_Ids: Codable, Hashable {
    
    var campaign: String
    var company: String
    var domain: String
    var gql: String
    var user: String

    enum CodingKeys: String, CodingKey {
        case campaign
        case company
        case domain
        case gql
        case user
    }
}
