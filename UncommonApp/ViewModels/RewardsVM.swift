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


class RewardsVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var var_getRewards = [Rewards]()
    
    func getRewards() {
        
        db.collection("rewards")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.var_getRewards = snapshot.documents.compactMap({ queryDocumentSnapshot -> Rewards? in
                    print("AT THE TRY STATEMENT for getRewards")
                    print(try? queryDocumentSnapshot.data(as: Rewards.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Rewards.self)
                })
            }
    
    }
    
}
