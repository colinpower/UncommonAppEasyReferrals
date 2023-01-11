//
//  CodeUpdateVM.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/9/23.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class CodeUpdateVM: ObservableObject, Identifiable {

    var dm = DataManager()
    
    private var db = Firestore.firestore()
    
//    @Published var one_code = Code(code: Code_Code(code: "", color: [], graphql_id: "", is_default: false), shop: Code_Shop(domain: "", name: "", website: ""), stats: Code_Stats(usage_count: -1, usage_limit: -1), status: Code_Status(did_creation_succeed: false, status: ""), timestamp: Code_Timestamp(created: -1, deleted: -1, used: -1), uuid: Code_UUID(campaign: "", code: "", membership: "", shop: "", user: ""))

    @Published var one_code_update = CodeUpdate(code: CodeUpdate_Code(color: [], current: "", graphql_id: "", is_default: false, new: ""), domain: "", status: "", timestamp: CodeUpdate_Timestamp(created: -1, updated: -1), uuid: "")
    
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
    
    func addCodeUpdate(code: Code, code_update_id: String, new_code: String) {
         
        let tstamp = Int(round(Date().timeIntervalSince1970))
        
        db.collection("codes").document(code.uuid.code).collection("updates").document(code_update_id).setData([
            "code": [
                "color": code.code.color,
                "current": code.code.code,
                "graphql_id": code.code.graphql_id,
                "is_default": code.code.is_default,
                "new": new_code
            ],
            "domain": code.shop.domain,
            "status": "PENDING",
            "timestamp": [
                "created": tstamp,
                "updated": -1
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
