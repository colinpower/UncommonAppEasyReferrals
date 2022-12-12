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


class MembershipsVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var var_getMyMemberships = [Memberships]()
    
    func getMyMemberships(userId: String) {
    
        //var ordersSnapshot = [Orders]()
        
        db.collection("memberships")
            .whereField("ids.user", isEqualTo: userId)
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.var_getMyMemberships = snapshot.documents.compactMap({ queryDocumentSnapshot -> Memberships? in
                    print("AT THE TRY STATEMENT for getMyMemberships")
                    print(try? queryDocumentSnapshot.data(as: Memberships.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Memberships.self)
                })
            }
    
    }
    
}
