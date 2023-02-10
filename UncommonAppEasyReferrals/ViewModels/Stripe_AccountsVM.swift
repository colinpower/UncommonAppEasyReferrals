//
//  Stripe_AccountVM.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/20/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Listen for one stripe account

class Stripe_AccountsVM: ObservableObject, Identifiable {

    var dm = DataManager()
    private var db = Firestore.firestore()
    
    @Published var one_stripe_account = EmptyVariables().empty_stripe_account
    var one_stripe_account_listener: ListenerRegistration!
    
    
    func listenForOneStripeAccount(user_id: String) {

        self.dm.getOneStripeAccountListener(user_id: user_id, onSuccess: { (stripe_account) in

            self.one_stripe_account = stripe_account
            
            print("FOUND STRIPE ACCOUNT")
            print(stripe_account.uuid.stripe_account)

        }, listener: { (listener) in
            self.one_stripe_account_listener = listener
        })
    }
    
    func createAccount(user_id: String) {

        db.collection("stripe_accounts").document(user_id).collection("link").addDocument(data: [
            "timestamp": getTimestamp(),
            ]) { err in
                if let err = err {
                    print("Error creating LINK: \(err)")
                } else {
                    print("ERROR CREATING STRIPE_ACCOUNT/LINK")
                }
            }
    }
    
    func checkAccount(user_id: String, acct_id: String) {

        db.collection("stripe_accounts").document(user_id).collection("check").addDocument(data: [
            "acct_id": acct_id,
            "timestamp": getTimestamp(),
            ]) { err in
                if let err = err {
                    print("Error creating LINK: \(err)")
                } else {
                    print("ERROR CHECKING STRIPE_ACCOUNT")
                }
            }
    }
    
    func updateBalance(user_id: String, acct_id: String) {

        db.collection("stripe_accounts").document(user_id).collection("balance").addDocument(data: [
            "acct_id": acct_id,
            "timestamp": getTimestamp(),
            ]) { err in
                if let err = err {
                    print("Error creating LINK: \(err)")
                } else {
                    print("ERROR UPDATING BALANCE")
                }
            }
    }
}
