//
//  CashRewardVM.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get all orders for user


class CashRewardVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var my_cash_rewards = [CashReward]()
    
    func getMyCashRewards() {
        
        db.collection("cash_rewards")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.my_cash_rewards = snapshot.documents.compactMap({ queryDocumentSnapshot -> CashReward? in
                    print("AT THE TRY STATEMENT for getMyCashRewards")
                    print(try? queryDocumentSnapshot.data(as: CashReward.self) as Any)
                    return try? queryDocumentSnapshot.data(as: CashReward.self)
                })
            }
    
    }
    
}
