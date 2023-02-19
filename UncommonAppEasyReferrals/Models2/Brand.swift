//
//  Brand.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Brand: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var brand_id: String
    var category: String
    var commission_type: String
    var commission_value: String
    var offer_type: String
    var offer_value: String
    var name: String
    var setup_image_ids: [String]
    var url: String
    var url_to_setup_referral: String
    var verification_method: String

    
    enum CodingKeys: String, CodingKey {
        case brand_id
        case category
        case commission_type
        case commission_value
        case offer_type
        case offer_value
        case name
        case setup_image_ids
        case url
        case url_to_setup_referral
        case verification_method
    }
}
