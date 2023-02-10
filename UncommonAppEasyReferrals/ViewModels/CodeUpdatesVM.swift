//
//  CodeUpdatesVM.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/23/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class CodeUpdatesVM: ObservableObject, Identifiable {

    var dm = DataManager()
    
    private var db = Firestore.firestore()

    @Published var one_code_update = EmptyVariables().empty_codeupdate
    var one_code_update_listener: ListenerRegistration!

    func listenForOneCode(code_id: String, code_update_id: String) {
        
        self.dm.getOneCodeUpdateListener(code_id: code_id, code_update_id: code_update_id, onSuccess: { (codeUpdate) in
            
            self.one_code_update = codeUpdate
            
            print("FOUND ONE CODE UPDATE")
            print(self.one_code_update)
            
        }, listener: { (listener) in
            self.one_code_update_listener = listener
        })
    }
    
    func addCodeUpdate(code: Codes, code_update_id: String, new_code: String) {
        
        db.collection("codes").document(code.uuid.code).collection("modify").document(code_update_id).setData([
            "code": [
                "code": code.code.code,
                "UPPERCASED": code.code.UPPERCASED,
                "color": code.code.color,
                "graphql_id": code.code.graphql_id,
                "is_default": code.code.is_default,
            ],
            "new_code": new_code,
            "shop": [
                "category": code.shop.category,
                "contact_support_email": code.shop.contact_support_email,
                "description": code.shop.description,
                "domain": code.shop.domain,
                "name": code.shop.name,
                "website": code.shop.website
            ],
            "status": "PENDING",
            "timestamp": [
                "created": getTimestamp(),
                "updated": 0
            ],
            "uuid": code_update_id
        ]) { err in
            if let err = err {
                print("Error creating CODE UPDATE: \(err)")
            } else {
                print("Other kind of error from CODE UPDATE.. idk??")
            }
        }
    }
    
    
    
    
}
