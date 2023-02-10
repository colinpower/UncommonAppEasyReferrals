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
    
    @Published var my_pending_referrals = [Referrals]()
    
    func getMyPendingReferrals() {
        
        db.collection("referrals")
            .whereField("_STATUS", isEqualTo: "PENDING")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.my_pending_referrals = snapshot.documents.compactMap({ queryDocumentSnapshot -> Referrals? in
                    print("AT THE TRY STATEMENT for getMyReferrals")
                    print(try? queryDocumentSnapshot.data(as: Referrals.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Referrals.self)
                })
            }
    
    }
    
}
