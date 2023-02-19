//
//  File.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var account_id: String
    var caption: String
    var image_ids: [String]
    var is_public: Bool
    var is_verified: Bool
    var purchase_id: String
    var user_id: String
    
    enum CodingKeys: String, CodingKey {
        case account_id
        case caption
        case image_ids
        case is_public
        case is_verified
        case purchase_id
        case user_id
    }
}
