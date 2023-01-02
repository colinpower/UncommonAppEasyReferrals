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


class CodesVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var var_getOneCode = Codes(code: "", doc_id: "", ids: Codes_Ids(campaign: "", company: "", domain: "", gql: "", user: ""), purpose: "", status: "", type: "", usage_count: 0, usage_limit: 0)
    
    func getOneCode(codeId: String) {
    
        //var ordersSnapshot = [Orders]()
    
        let docRef = db.collection("codes").document(codeId)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error)")
            }
            else {
                if let document = document {
                    do {
                        self.var_getOneCode = try document.data(as: Codes.self)
                        print(self.var_getOneCode)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
        
        
//            .getDocuments { (snapshot, error) in
//
//                guard let snapshot = snapshot, error == nil else {
//                    //handle error
//                    print("found error")
//                    return
//                }
//                print("Number of documents: \(snapshot.documents.count)")
//
//                self.var_getOneCampaign = snapshot.documents.compactMap({ queryDocumentSnapshot -> Campaigns? in
//                    print("AT THE TRY STATEMENT for getOneCampaign")
//                    print(try? queryDocumentSnapshot.data(as: Campaigns.self) as Any)
//                    return try? queryDocumentSnapshot.data(as: Campaigns.self)
//                })
//            }
    
    }
    
}
