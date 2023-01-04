//
//  File.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get all memberships for user


class MembershipVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var my_memberships = [Membership]()
    
    func getMyMemberships(userId: String) {
    
        //var ordersSnapshot = [Orders]()
        
        db.collection("memberships")
            .whereField("status", isEqualTo: "ACTIVE")
//            .whereField("ids.user", isEqualTo: userId)
            .getDocuments { (snapshot, error) in
    
                print("trying to get memberships for \(userId)")
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("!!!!!!! found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.my_memberships = snapshot.documents.compactMap({ queryDocumentSnapshot -> Membership? in
                    print("AT THE TRY STATEMENT for getMyMemberships")
                    print(try? queryDocumentSnapshot.data(as: Membership.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Membership.self)
                })
            }
    
    }
    
}
