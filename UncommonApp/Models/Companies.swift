//
//  Companies.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Companies: Identifiable, Codable, Hashable {

    @DocumentID var id: String? = UUID().uuidString
    var account: Companies_Account
    var campaigns: [String]
    var doc_id: String
    var joining_requirements: Companies_JoiningRequirements
    var profile: Companies_Profile
    var status: String

    enum CodingKeys: String, CodingKey {
        case account
        case campaigns
        case doc_id
        case joining_requirements
        case profile
        case status
    }
}


struct Companies_Account: Codable, Hashable {

    var email: String
    var joined: Int

    enum CodingKeys: String, CodingKey {
        case email
        case joined
    }
}

struct Companies_JoiningRequirements: Codable, Hashable {
    
    var is_customer: Bool

    enum CodingKeys: String, CodingKey {
        case is_customer
    }
}

struct Companies_Profile: Codable, Hashable {

    var category: String
    var description: String
    var domain: String
    var logo: String
    var name: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case category
        case description
        case domain
        case logo
        case name
        case url
    }
}
