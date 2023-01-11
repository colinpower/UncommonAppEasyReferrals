//
//  CodeUpdate.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/9/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct CodeUpdate: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var code: CodeUpdate_Code
    var domain: String
    var status: String
    var timestamp: CodeUpdate_Timestamp
    var uuid: String

    enum CodingKeys: String, CodingKey {
        case code
        case domain
        case status
        case timestamp
        case uuid
    }
}

struct CodeUpdate_Code: Codable, Hashable {
    
    var color: [Int]
    var current: String
    var graphql_id: String
    var is_default: Bool
    var new: String
    
    
    enum CodingKeys: String, CodingKey {
        case color
        case current
        case graphql_id
        case is_default
        case new
    }
}

struct CodeUpdate_Timestamp: Codable, Hashable {
    
    var created: Int
    var updated: Int

    enum CodingKeys: String, CodingKey {
        case created
        case updated
    }
}
