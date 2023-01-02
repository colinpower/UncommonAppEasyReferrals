//
//  AppViewModel.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Combine



class UserObject {
    var uid: String
    var email: String?

    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}


class AppViewModel: ObservableObject {
    
    @Published var signedIn = false
    @Published var currentUser1: Users?
    
    @Published var isNewUserAuth = false
    
    let auth = Auth.auth()
    let email = Auth.auth().currentUser?.email
    let userID = Auth.auth().currentUser?.uid
    //let test = Auth.auth().currentUser?.displayName
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    var didChange = PassthroughSubject<AppViewModel, Never>()
    @Published var session: UserObject? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    //need to remove the listener so you're not constantly listening
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func listen () {
        
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth1, user1) in
            if let user1 = user1 {
                // if we have a user, create a new user model
                
                print("we have a session.. setting it to UserObject of the current user")
                print("Got user: \(user1)")
                
                //UsersVM().listenForOneUser(userID: user1.uid)
                
                UsersVM().checkForUser(email: user1.email ?? "")
                
                print(String(user1.uid))
                print(user1.email ?? "")
                
                self.session = UserObject(
                    uid: user1.uid,
                    email: user1.email
                )
                
                

                print("printing the UserObject which is self.session")
                print(self.session)
                
                
            } else {
                print("we don't have a session.. setting it to nil")
                // if we don't have a user, set our session to nil
                self.session = nil
                
                
            }
        }
        
    }
    
    func passwordlessSignIn(email1: String, link1: String,
                                      completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email1, link: link1) { result1, error1 in
            
          if let error1 = error1 {
            print("Authentication error: \(error1.localizedDescription).")
            completion(.failure(error1))
          } else {
              
              //let isNew123 = result1?.additionalUserInfo?.isNewUser
              //result1?
              
//              if (isNew123 != nil) {
//                  print("is this a new user? \(isNew123)")
//                  self.isNewUserAuth = (isNew123 ?? false)
//              }
//              if let result1 = result1 {
//                  isNewUser2 = result1?.user.additional
//              }
//              if let isNewUser1 = result1?.user.additionalUserInfo.isNewUser {
//                  isNewUser = isNewUser1
//              }
            print(result1?.user.uid)
            print("Authentication was successful.")
              completion(.success(result1?.user))
          }
        }
      }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.signedIn = false
            self.session = nil
            
            return true
            
        } catch {
            
            return false
            
        }
    }
}
