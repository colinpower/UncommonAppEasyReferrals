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
    
    @Published var one_code = Code(code: Code_Code(code: "", color: [], graphql_id: "", is_default: false), shop: Code_Shop(domain: "", name: "", website: ""), stats: Code_Stats(usage_count: -1, usage_limit: -1), status: Code_Status(did_creation_succeed: false, status: ""), timestamp: Code_Timestamp(created: -1, deleted: -1, used: -1), uuid: Code_UUID(campaign: "", code: "", membership: "", shop: "", user: ""))
//    @Published var one_code = Code(code: "", doc_id: "", ids: Codes_Ids(campaign: "", company: "", domain: "", gql: "", user: ""), purpose: "", status: "", type: "", usage_count: 0, usage_limit: 0)
    
    func getOneCode(codeId: String) {
    
        //var ordersSnapshot = [Orders]()
    
        //let docRef = db.collection("codes").document(codeId)
        let docRef = db.collection("codes").document("Fr2FcjT5gkCcq01fSGlc")
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error)")
            }
            else {
                if let document = document {
                    do {
                        self.one_code = try document.data(as: Code.self)
                        print(self.one_code)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
    
}
