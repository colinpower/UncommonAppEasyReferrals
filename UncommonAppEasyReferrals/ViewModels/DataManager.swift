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
    
    
    func getOneUserListener(userID: String, onSuccess: @escaping([Users]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        
        let listenerRegistration = db.collection("users")
            .whereField("doc_id", isEqualTo: userID)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                var oneUserArray = [Users]()
                
                oneUserArray = documents.compactMap { (queryDocumentSnapshot) -> Users? in
                    print("SINGLE USER")
                    print(try? queryDocumentSnapshot.data(as: Users.self))
                    return try? queryDocumentSnapshot.data(as: Users.self)
                    //return try? queryDocumentSnapshot.data(as: Ticket.self)
                }
                onSuccess(oneUserArray)
            }
        listener(listenerRegistration) //escaping listener
    }
    
    
    
    func getCurrentUserByUID(userID: String, onSuccess: @escaping(Users) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        let listenerRegistration = db.collection("users").document(userID)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
//                guard let data = document.data() else {
//                    print("Document data was empty.")
//                    return
//                }
                
                 var oneUserVariable = Users(account: Users_Account(available_cash: 0, available_discounts: 0), doc_id: "EMPTY_USER", profile: Users_Profile(email: "", first_name: "", last_name: "", phone: "", phone_verified: false), settings: Users_Settings(notifications: false), timestamps: Users_Timestamps(joined: 0))
                
//                var oneUserVariable = try document.data(as: Users.self)
                
//                oneUserArray = documents.compactMap { (queryDocumentSnapshot) -> Users? in
//                    print("SINGLE USER")
//                    print(try? queryDocumentSnapshot.data(as: Users.self))
//                    return try? queryDocumentSnapshot.data(as: Users.self)
//                    //return try? queryDocumentSnapshot.data(as: Ticket.self)
//                }
//                onSuccess(oneUserVariable)
                
                //if let document = document {
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
                
    
    
    
    
    func getOneAuthResult(userID: String, newUUID: String, onSuccess: @escaping([AuthResult]) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        
        let listenerRegistration = db.collection("users").document(userID).collection("auth_result")
            .whereField("doc_id", isEqualTo: newUUID)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                var oneAuthResultArray = [AuthResult]()
                
                oneAuthResultArray = documents.compactMap { (queryDocumentSnapshot) -> AuthResult? in
                    print("SINGLE USER")
                    print(try? queryDocumentSnapshot.data(as: AuthResult.self))
                    return try? queryDocumentSnapshot.data(as: AuthResult.self)
                    //return try? queryDocumentSnapshot.data(as: Ticket.self)
                }
                onSuccess(oneAuthResultArray)
            }
        listener(listenerRegistration) //escaping listener
    }
    
}



//
//let docRef = db.collection("codes").document(codeId)
//
//docRef.getDocument { document, error in
//    if let error = error as NSError? {
//        print("Error getting document: \(error)")
//    }
//    else {
//        if let document = document {
//            do {
//                self.var_getOneCode = try document.data(as: Codes.self)
//                print(self.var_getOneCode)
//            }
//            catch {
//                print(error)
//            }
//        }
//    }
//}