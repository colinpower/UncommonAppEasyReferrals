//
//  CodesVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get one code


class CodeVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
//    @Published var one_code = Code(code: Code_Code(code: "", color: [], graphql_id: "", is_default: false), shop: Code_Shop(domain: "", name: "", website: ""), stats: Code_Stats(usage_count: -1, usage_limit: -1), status: Code_Status(did_creation_succeed: false, status: ""), timestamp: Code_Timestamp(created: -1, deleted: -1, used: -1), uuid: Code_UUID(campaign: "", code: "", membership: "", shop: "", user: ""))

    @Published var one_code = Code(code: Code_Code(code: "", color: [], graphql_id: "", is_default: false), shop: Code_Shop(domain: "", name: "", website: ""), stats: Code_Stats(usage_count: -1, usage_limit: -1), status: Code_Status(did_creation_succeed: false, status: "EMPTY"), timestamp: Code_Timestamp(created: -1, deleted: -1, used: -1), uuid: Code_UUID(campaign: "", code: "", membership: "", shop: "", user: "")) {
        didSet {
            print("updated the one_code variable.. here it is...")
            print(one_code)
        }
    }
    
    @Published var one_code_static = Code(code: Code_Code(code: "", color: [], graphql_id: "", is_default: false), shop: Code_Shop(domain: "", name: "", website: ""), stats: Code_Stats(usage_count: -1, usage_limit: -1), status: Code_Status(did_creation_succeed: false, status: "EMPTY"), timestamp: Code_Timestamp(created: -1, deleted: -1, used: -1), uuid: Code_UUID(campaign: "", code: "", membership: "", shop: "", user: ""))
    
    var one_code_listener: ListenerRegistration!
        
    
    
    func getOneCode(code_id: String) {

        let docRef = db.collection("codes").document(code_id)

        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error)")
            }
            else {
                if let document = document {
                    do {
                        self.one_code_static = try document.data(as: Code.self)
                        print(self.one_code_static)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    func listenForOneCode(code_id: String) {
        
        self.dm.getOneCodeListener(code_id: code_id, onSuccess: { (code) in
            
            self.one_code = code
            
            print("FOUND ONE CODE")
            print(self.one_code)
            
        }, listener: { (listener) in
            self.one_code_listener = listener
        })
    }
    
    func addCode(shop: Shop, campaign: Campaign, user_id: String, code_id: String, code: String = "") {
         
        db.collection("codes").document(code_id).setData([
            "code": [
                "code": code,
                "color": [255, 255, 255],
                "graphql_id": "",
                "is_default": true
            ],
            "shop": [
                "domain": shop.info.domain,
                "name": shop.info.name,
                "website": shop.info.website
            ],
            "stats": [
                "usage_count": 0,
                "usage_limit": campaign.offer.usage_limit
            ],
            "status": [
                "did_creation_succeed": false,
                "status": "PENDING"
            ],
            "timestamp": [
                "created": Int(round(Date().timeIntervalSince1970)),
                "deleted": -1,
                "used": -1
            ],
            "uuid": [
                "campaign": campaign.uuid.campaign,
                "code": code_id,
                "membership": user_id + "-" + shop.uuid.shop,
                "shop": shop.uuid.shop,
                "user": user_id
            ]
        ]) { err in
            if let err = err {
                print("Error creating CODE: \(err)")
            } else {
                print("Other kind of error.. idk??")
            }
        }
    }
    
    
    
    
}
