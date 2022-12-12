//
//  Orders.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Orders: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var doc_id: String
    var ids: Orders_Ids
    var values: Orders_Values

    enum CodingKeys: String, CodingKey {
        case doc_id
        case ids
        case values
    }
}

struct Orders_Ids: Codable, Hashable {
    
    var code: String
    var company: String
    var domain: String
    var platform: String
    var platform_order: String

    enum CodingKeys: String, CodingKey {
        case code
        case company
        case domain
        case platform
        case platform_order
    }
}

struct Orders_Values: Codable, Hashable {

    var code_text: String
    var total_discount: Int
    var total_price: Int

    enum CodingKeys: String, CodingKey {
        case code_text
        case total_discount
        case total_price
    }
}
