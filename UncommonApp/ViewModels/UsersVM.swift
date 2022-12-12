//
//  UsersVM.swift
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


class UsersVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var allUsers = [Users]()
    
    func getAllUsers() {
        
        db.collection("users")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.allUsers = snapshot.documents.compactMap({ queryDocumentSnapshot -> Users? in
                    print("AT THE TRY STATEMENT for getAllUsers")
                    print(try? queryDocumentSnapshot.data(as: Users.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Users.self)
                })
            }
    
    }
    
}
