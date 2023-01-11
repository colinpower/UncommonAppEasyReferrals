//
//  StripeVM.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/11/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Add stripe_user
    // Listen for stripe_user
    // Get stripe_user

class StripeVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    

    @Published var one_stripe = Stripe(account: Stripe_Account(id: "", link: "", charges_enabled: false, details_submitted: false, currently_due: [], eventually_due: []), balance: Stripe_Balance(pending: -1, available: -1, stripe: -1), info: Stripe_Info(first_name: "", last_name: "", email: "", phone: ""), timestamp: Stripe_Timestamp(created: -1, last_updated: -1), uuid: Stripe_UUID(user: "", stripe: "", last_update: ""))
//
//    @Published var one_code_static = Code(code: Code_Code(code: "", color: [], graphql_id: "", is_default: false), shop: Code_Shop(domain: "", name: "", website: ""), stats: Code_Stats(usage_count: -1, usage_limit: -1), status: Code_Status(did_creation_succeed: false, status: "EMPTY"), timestamp: Code_Timestamp(created: -1, deleted: -1, used: -1), uuid: Code_UUID(campaign: "", code: "", membership: "", shop: "", user: ""))
//
    var one_stripe_listener: ListenerRegistration!
//
    
    
//    func getOneCode(code_id: String) {
//
//        let docRef = db.collection("codes").document(code_id)
//
//        docRef.getDocument { document, error in
//            if let error = error as NSError? {
//                print("Error getting document: \(error)")
//            }
//            else {
//                if let document = document {
//                    do {
//                        self.one_code_static = try document.data(as: Code.self)
//                        print(self.one_code_static)
//                    }
//                    catch {
//                        print(error)
//                    }
//                }
//            }
//        }
//    }
//
    func listenForOneStripe(user_id: String) {

        self.dm.getOneStripeListener(user_id: user_id, onSuccess: { (stripe) in

            self.one_stripe = stripe

            print("FOUND ONE STRIPE")
            print(self.one_stripe)

        }, listener: { (listener) in
            self.one_stripe_listener = listener
        })
    }
    
    func createStripeAccount(user: Users) {
        
        var current_timestamp = Int(round(Date().timeIntervalSince1970))
        
        db.collection("stripe").document(user.doc_id).setData([
            "account": [
                "id": "",
                "link": "",
                "charges_enabled": false,
                "details_submitted": false,
                "currently_due": [],
                "eventually_due": []
            ],
            "balance": [
                "pending": 0,
                "available": 0,
                "stripe": -1
            ],
            "info": [
                "first_name": user.profile.first_name,
                "last_name": user.profile.last_name,
                "email": user.profile.email,
                "phone": user.profile.phone,
            ],
            "uuid": [
                "user": user.doc_id,
                "stripe": user.doc_id,
                "last_update": "",
            ],
            "timestamp": [
                "created": current_timestamp,
                "last_updated": -1,
            ]
        ]) { err in
            if let err = err {
                print("Error creating STRIPE: \(err)")
            } else {
                print("Other kind of error creating the stripe account.. idk??")
                print(err)
            }
        }
    }
    
    
    
    
}
