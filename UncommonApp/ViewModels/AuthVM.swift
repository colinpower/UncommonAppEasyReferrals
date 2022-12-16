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

class AuthVM: ObservableObject, Identifiable {
    
    private var db = Firestore.firestore()
    
    func addAuthRequest(
        //firstName: String,
        //lastName: String,
        email: String
    ) {
        
        let authTimestamp = Int(round(Date().timeIntervalSince1970))
        let authUUID = UUID().uuidString
        
        db.collection("auth").document(authUUID)
            .setData([
                
                "sender": [
                    //"firstName": firstName,
                    //"lastName": lastName,
                    //"phone": "",
                    "email": email
                ]
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("IDK WHAT THE ERROR IS??")
                }
            }
    }
    
}
