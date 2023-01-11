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
    
    @Published var one_user = Users(account: Users_Account(available_cash: 0, available_discounts: -1), doc_id: "", profile: Users_Profile(email: "", first_name: "NOT_SET", last_name: "NOT_SET", phone: "", phone_verified: true), settings: Users_Settings(notifications: false), timestamps: Users_Timestamps(joined: -1))
    
    var one_user_listener: ListenerRegistration!

    
    
    
    @Published var allUsers = [Users]()
    @Published var oneUser = [Users]()
    
    @Published var oneAuthResult = [AuthResult]()
    
    @Published var currentUserByUID = Users(account: Users_Account(available_cash: 0, available_discounts: 0), doc_id: "EMPTY_USER", profile: Users_Profile(email: "", first_name: "", last_name: "", phone: "", phone_verified: false), settings: Users_Settings(notifications: false), timestamps: Users_Timestamps(joined: 0))
    
    var listener_OneUser: ListenerRegistration!
    var listener_oneAuthResult: ListenerRegistration!
    var listener_CurrentUserByUID: ListenerRegistration!

    
    func listenForOneUserNEW(user_id: String) {

        self.dm.getOneUserListenerNEW(user_id: user_id, onSuccess: { (user) in

            self.one_user = user

            print("FOUND ONE USER!!!")
            print(self.one_user)

        }, listener: { (listener) in
            self.one_user_listener = listener
        })
    }
    
    
    
    
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
    
    func listenForOneUser(userID: String) {
        self.oneUser = [Users]()
        
        self.dm.getOneUserListener(userID: userID, onSuccess: { (User) in
            
            self.oneUser = User
            
            print("USER HAS BEEN UPDATED")
            print(self.oneUser)
            
        }, listener: { (listener) in
            self.listener_OneUser = listener
        })
    }
    
    
    
    func listenForUserByUID(userID: String) {
        
        self.dm.getCurrentUserByUID(userID: userID, onSuccess: { (User1) in
            
            self.currentUserByUID = User1
            
            print("USER HAS BEEN UPDATED")
            print(self.currentUserByUID)
            
        }, listener: { (listener) in
            self.listener_CurrentUserByUID = listener
        })
    }
    
    
    @Published var didFindUser:Bool = true
    
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
    
    
    
    func requestOTP(
        userID: String,
        phone: String,
        newUUID: String
    ) {
        
        let OTPTimestamp = Int(round(Date().timeIntervalSince1970))
        //let emailAuthUUID = UUID().uuidString
        print("THIS IS THE USER ID AS OF NOW")
        print(userID)
        print("REQUESTING OTP!!!")
        
        db.collection("users").document(userID).collection("auth_request").document(newUUID)
            .setData([
                "id": newUUID,
                "phone": phone,
                "phone_verified": false,
                "auth_code_generated": "",
                "auth_code_submitted": "",
                "timestamp_created": OTPTimestamp,
                "timestamp_expires": OTPTimestamp + 180,
                "timestamp_submitted": 0
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("IDK ERROR WHEN SUBMITTING??")
                }
            }
    }
    
    func submitOTP(user_id: String, code: String, newUUID: String) {
        let timestamp = Int(round(Date().timeIntervalSince1970))
        //let emailAuthUUID = UUID().uuidString
        
        if user_id.isEmpty {
            return
        } else {
            
            db.collection("users").document(user_id).collection("auth_request").document(newUUID)
                .updateData([
                    "timestamp_submitted": timestamp,
                    "auth_code_submitted": code
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("sending a verification code back to firebase")
                    }
                }
        }
    }
    
    func listenForPhoneVerification(user_id: String, newUUID: String) {
        
        if user_id.isEmpty {
            return
        } else {
            
            self.oneAuthResult = [AuthResult]()
            
            self.dm.getOneAuthResult(userID: user_id, newUUID: newUUID, onSuccess: { (result) in
                
                self.oneAuthResult = result
                print("this is the one result")
                print(self.oneAuthResult)
            }, listener: { (listener) in
                self.listener_oneAuthResult = listener
            })
        }
    }
    
    func submitNames(uid: String, first_name: String, last_name: String) {
        
        if uid.isEmpty {
            return
        } else {
            
            db.collection("users").document(uid)
                .updateData([
                    "profile.first_name": first_name,
                    "profile.last_name": last_name
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
