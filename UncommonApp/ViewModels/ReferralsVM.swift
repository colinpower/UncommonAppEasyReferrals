//
//  ReferralsVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get all orders for user


class ReferralsVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var var_getReferrals = [Referrals]()
    
    func getReferrals() {
        
        db.collection("referrals")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.var_getReferrals = snapshot.documents.compactMap({ queryDocumentSnapshot -> Referrals? in
                    print("AT THE TRY STATEMENT for getReferrals")
                    print(try? queryDocumentSnapshot.data(as: Referrals.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Referrals.self)
                })
            }
    
    }
    
}
