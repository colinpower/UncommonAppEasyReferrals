//
//  DataManager.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataManager: ObservableObject {
    
    private var db = Firestore.firestore()
    
    func getCurrentUserByUID(userID: String, onSuccess: @escaping(Users) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        let listenerRegistration = db.collection("users").document(userID)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                
                var oneUserVariable = Users(profile: Struct_Profile(email: "", email_verified: false, name: Struct_Profile_Name(first: "", last: ""), phone: "", phone_verified: false), settings: Users_Settings(has_notifications: false), timestamp: Users_Timestamp(created: 0, deleted: 0), uuid: Users_UUID(user: ""))
                
                do {
                    print("GOT HERE IN THE GETCURRENTUSERBYUID")
                    oneUserVariable = try! document.data(as: Users.self)
                    //return oneUserVariable //try? document.data(as: Users.self)
                }
                catch {
                    print(error)
                    return
                }
                //}
                onSuccess(oneUserVariable)
            }
        listener(listenerRegistration) //escaping listener
    }
    
    func getOneUserListener(user_id: String, onSuccess: @escaping(Users) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {

        let listenerRegistration = db.collection("users").document(user_id)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }

                var emptyUser = Users(profile: Struct_Profile(email: "", email_verified: false, name: Struct_Profile_Name(first: "", last: ""), phone: "", phone_verified: false), settings: Users_Settings(has_notifications: false), timestamp: Users_Timestamp(created: 0, deleted: 0), uuid: Users_UUID(user: ""))

                do {
                    print("GOT HERE IN THE getOneUserListener")
                    //try document.data(as: Code.self)
                    if document.exists {
                        emptyUser = try! document.data(as: Users.self)
                    } else {
                        emptyUser.uuid.user = "NO USER FOUND"
                    }
                }
                catch {
                    print(error)
                    return
                }
                onSuccess(emptyUser)
            }
        listener(listenerRegistration) //escaping listener
    }
    
    func getOneStripeAccountListener(user_id: String, onSuccess: @escaping(Stripe_Accounts) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {

        let listenerRegistration = db.collection("stripe_accounts").document(user_id)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }

                var empty_account = EmptyVariables().empty_stripe_account

                do {
                    if document.exists {
                        empty_account = try! document.data(as: Stripe_Accounts.self)
                    } else {
                        empty_account.uuid.user = "NO USER FOUND"
                    }
                }
                catch {
                    print(error)
                    return
                }
                onSuccess(empty_account)
            }
        listener(listenerRegistration)
    }
    
    func getMyMembershipsListener(user_id: String, onSuccess: @escaping([Memberships]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {

        let listenerRegistration = db.collection("memberships")
            .whereField("uuid.user", isEqualTo: user_id)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }

                var myMembershipsArray = [Memberships]()

                myMembershipsArray = documents.compactMap { (queryDocumentSnapshot) -> Memberships? in

                    print(try? queryDocumentSnapshot.data(as: Memberships.self))
                    return try? queryDocumentSnapshot.data(as: Memberships.self)
                }
                onSuccess(myMembershipsArray)
                
            }
        listener(listenerRegistration) //escaping listener
    }
    
    func getOneCodeListener(code_id: String, onSuccess: @escaping(Codes) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {

        let listenerRegistration = db.collection("codes").document(code_id)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }

                var single_code = EmptyVariables().empty_code

                do {
                    print("GOT HERE IN THE getOneCodeListener")
                    if document.exists {
                        single_code = try! document.data(as: Codes.self)
                    } else {
                        single_code.status = "NO CODE FOUND"
                    }
                }
                catch {
                    print(error)
                    return
                }
                onSuccess(single_code)
            }
        listener(listenerRegistration) //escaping listener
    }
    
    func getMyActiveDiscountCodesListener(user_id: String, onSuccess: @escaping([Codes]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {

        let listenerRegistration = db.collection("codes")
            .whereField("uuid.user", isEqualTo: user_id)
            .whereField("_PURPOSE", isEqualTo: "REWARD")
            .whereField("status", isEqualTo: "ACTIVE")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }

                var myActiveDiscountCodes = [Codes]()

                myActiveDiscountCodes = documents.compactMap { (queryDocumentSnapshot) -> Codes? in

                    print(try? queryDocumentSnapshot.data(as: Codes.self))
                    return try? queryDocumentSnapshot.data(as: Codes.self)
                }
                onSuccess(myActiveDiscountCodes)
                
            }
        listener(listenerRegistration) //escaping listener
    }
    
    func getOneCodeUpdateListener(code_id: String, code_update_id: String, onSuccess: @escaping(CodeUpdates) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {

        let listenerRegistration = db.collection("codes").document(code_id).collection("modify").document(code_update_id)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }

                var single_code_update = EmptyVariables().empty_codeupdate

                do {
                    print("GOT HERE IN THE getOneCodeUpdateListener")
                    if document.exists {
                        single_code_update = try! document.data(as: CodeUpdates.self)
                    } else {
                        single_code_update.status = "NO CODE FOUND"
                    }
                }
                catch {
                    print(error)
                    return
                }
                onSuccess(single_code_update)
            }
        listener(listenerRegistration) //escaping listener
    }
    
}


//    func getOneAuthResult(userID: String, newUUID: String, onSuccess: @escaping([AuthResult]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
//        
//        
//        let listenerRegistration = db.collection("users").document(userID).collection("auth_result")
//            .whereField("doc_id", isEqualTo: newUUID)
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents")
//                    return
//                }
//                var oneAuthResultArray = [AuthResult]()
//                
//                oneAuthResultArray = documents.compactMap { (queryDocumentSnapshot) -> AuthResult? in
//                    print("SINGLE USER")
//                    print(try? queryDocumentSnapshot.data(as: AuthResult.self))
//                    return try? queryDocumentSnapshot.data(as: AuthResult.self)
//                    //return try? queryDocumentSnapshot.data(as: Ticket.self)
//                }
//                onSuccess(oneAuthResultArray)
//            }
//        listener(listenerRegistration) //escaping listener
//    }
    
//    func listenForMyMemberships(uid: String, onSuccess: @escaping([Membership]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
//        
//        let listenerRegistration = db.collection("memberships")
//            .whereField("uuid.user", isEqualTo: uid)
//            //.order(by: "card.companyName", descending: false)
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents")
//                    return
//                }
//                var myMembershipsArray = [Membership]()
//                
//                myMembershipsArray = documents.compactMap { (queryDocumentSnapshot) -> Membership? in
//                    
//                    print("here's my membership info...")
//                    print(try? queryDocumentSnapshot.data(as: Membership.self))
//                    return try? queryDocumentSnapshot.data(as: Membership.self)
//                }
//                onSuccess(myMembershipsArray)
//            }
//        listener(listenerRegistration)
//    }
//    

//    
//    
//    func getOneCodeUpdateListener(code_id: String, code_update_id: String, onSuccess: @escaping(CodeUpdate) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
//        
//        let listenerRegistration = db.collection("codes").document(code_id).collection("updates").document(code_update_id)
//            .addSnapshotListener { documentSnapshot, error in
//                guard let document = documentSnapshot else {
//                    print("Error fetching CodeUpdate document: \(error!)")
//                    return
//                }
//                
//                var emptyCodeUpdate = CodeUpdate(code: CodeUpdate_Code(color: [], current: "", graphql_id: "", is_default: false, new: ""), domain: "", status: "", timestamp: CodeUpdate_Timestamp(created: -1, updated: -1), uuid: "")
//                
//                do {
//                    print("GOT HERE IN THE getOneCodeUpdateListener")
//                    //try document.data(as: Code.self)
//                    if document.exists {
//                        emptyCodeUpdate = try! document.data(as: CodeUpdate.self)
//                    } else {
//                        emptyCodeUpdate.status = "NO CODE UPDATE FOUND"
//                    }
//                }
//                catch {
//                    print(error)
//                    return
//                }
//                onSuccess(emptyCodeUpdate)
//            }
//        listener(listenerRegistration) //escaping listener
//    }
//    

//    
//    
//    func getOneStripeListener(user_id: String, onSuccess: @escaping(Stripe) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
//        
//        let listenerRegistration = db.collection("stripe").document(user_id)
//            .addSnapshotListener { documentSnapshot, error in
//                guard let document = documentSnapshot else {
//                    print("Error fetching document: \(error!)")
//                    return
//                }
//                
//                var emptyStripe = Stripe(account: Stripe_Account(id: "", link: "", charges_enabled: false, details_submitted: false, currently_due: [], eventually_due: []), balance: Stripe_Balance(pending: -1, available: -1, stripe: -1), info: Stripe_Info(first_name: "", last_name: "", email: "", phone: ""), timestamp: Stripe_Timestamp(created: -1, last_updated: -1), uuid: Stripe_UUID(user: "", stripe: "", last_update: ""))
//                
//                do {
//                    print("GOT HERE IN THE getOneStripeListener")
//                    
//                    if document.exists {
//                        emptyStripe = try! document.data(as: Stripe.self)
//                    } else {
//                        emptyStripe.account.id = "NO STRIPE FOUND"
//                    }
//                }
//                catch {
//                    print(error)
//                    return
//                }
//                onSuccess(emptyStripe)
//            }
//        listener(listenerRegistration) //escaping listener
//    }
//
//    
//    
//}
//
//
//
//
////
////let docRef = db.collection("codes").document(codeId)
////
////docRef.getDocument { document, error in
////    if let error = error as NSError? {
////        print("Error getting document: \(error)")
////    }
////    else {
////        if let document = document {
////            do {
////                self.var_getOneCode = try document.data(as: Codes.self)
////                print(self.var_getOneCode)
////            }
////            catch {
////                print(error)
////            }
////        }
////    }
////}
