//
//  RewardsVM.swift
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


class DiscountRewardVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var my_discount_rewards = [DiscountReward]()
    
    func getMyDiscountRewards() {
        
        db.collection("discount_rewards")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.my_discount_rewards = snapshot.documents.compactMap({ queryDocumentSnapshot -> DiscountReward? in
                    print("AT THE TRY STATEMENT for getRewards")
                    print(try? queryDocumentSnapshot.data(as: DiscountReward.self) as Any)
                    return try? queryDocumentSnapshot.data(as: DiscountReward.self)
                })
            }
    
    }
    
}
