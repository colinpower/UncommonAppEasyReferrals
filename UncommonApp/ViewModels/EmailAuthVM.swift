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





class EmailAuthVM: ObservableObject, Identifiable {
    
    @Published var var_getReferrals = [Referrals]()
    
    
    private var db = Firestore.firestore()
    
    func addEmailAuthRequest(
        //firstName: String,
        //lastName: String,
        email: String
    ) {
        
        let emailAuthTimestamp = Int(round(Date().timeIntervalSince1970))
        let emailAuthUUID = UUID().uuidString
        
        db.collection("auth").document(emailAuthUUID)
            .setData([
                "email": email
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("IDK WHAT THE ERROR IS??")
                }
            }
    }
    
}
