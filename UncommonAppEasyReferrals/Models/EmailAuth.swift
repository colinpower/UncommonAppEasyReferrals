//
//  Auth.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EmailAuth: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var email: String

    //use CodingKeys to convert from names in Firebase to SwiftUI names
    enum CodingKeys: String, CodingKey {

        case email

    }
}
