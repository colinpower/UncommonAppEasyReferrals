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


class ReferralVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    @Published var my_referrals = [Referral]()
    
    func getMyReferrals() {
        
        db.collection("referrals")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.my_referrals = snapshot.documents.compactMap({ queryDocumentSnapshot -> Referral? in
                    print("AT THE TRY STATEMENT for getMyReferrals")
                    print(try? queryDocumentSnapshot.data(as: Referral.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Referral.self)
                })
            }
    
    }
    
}
