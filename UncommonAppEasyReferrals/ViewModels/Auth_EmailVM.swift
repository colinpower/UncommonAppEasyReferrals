//
//  AuthVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class Auth_EmailVM: ObservableObject, Identifiable {

    private var db = Firestore.firestore()
    
    func requestEmailLink(email: String) {
        
        let timestamp = getTimestamp()
        
        db.collection("auth_email").document()
            .setData([
                "email": email,
                "timestamp": getTimestamp()
            ]) { err in
                if let err = err {
                    print("Error adding document for requestEmailLink: \(err)")
                } else {
                    print("ERROR with requesting email link? \(err)")
                }
            }
    }
    
}
