//
//  ReferralProgram.swift
//  UncommonApp
//
//  Created by Colin Power on 12/7/22.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ReferralProgram: Identifiable, Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var foo: String
    
    
    enum CodingKeys: String, CodingKey {    //convert from Firebase to SwiftUI names
        case foo

    }
}
