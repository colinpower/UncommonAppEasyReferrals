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
    // Listen for one user
    // Check if one user exists (with email)
    // Add names for user


class UsersVM: ObservableObject, Identifiable {

    var dm = DataManager()
    private var db = Firestore.firestore()
    
    @Published var one_user = EmptyVariables().empty_user
    @Published var didFindUser:Bool = true
    
    var one_user_listener: ListenerRegistration!
    

    
    func listenForOneUser(user_id: String) {

        self.dm.getOneUserListener(user_id: user_id, onSuccess: { (user) in

            self.one_user = user

            print("FOUND ONE USER!!!")
            print(self.one_user)

        }, listener: { (listener) in
            self.one_user_listener = listener
        })
    }
    
    func checkForUser(email: String) {
        
        db.collection("users")
            .whereField("profile.email", isEqualTo: email)
            .limit(to: 1)
            .getDocuments { (snap, err) in
                
                guard let snapshot = snap, err == nil else {
                    print("found error trying to get user")
                    self.didFindUser = true
                    return
                }
                
                if (snapshot.documents.count == 0) {
                    //handle scenario where user isn't found
                    print("did not find any documents for the email \(email)")
                    self.didFindUser = false
                    return
                } else {
                    print("Found at least 1 document, so there's a user")
                    self.didFindUser = true
                    return
                }
            }   
    }
    
    func submitNames(user_id: String, first_name: String, last_name: String) {
        
        if user_id.isEmpty { return } else {
            
            db.collection("users").document(user_id)
                .updateData([
                    "profile.name.first": first_name,
                    "profile.name.last": last_name
                ]) { err in
                    if let err = err {
                        print("Error updating document submitting names for User object: \(err)")
                    } else {
                        print("Updated the first and last names")
                    }
                }
        }
    }
    
    
}
