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
    
    func listen (users_vm: UsersVM, stripe_accounts_vm: Stripe_AccountsVM) {
        
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth1, user1) in
            if let user1 = user1 {
                // if we have a user, create a new user model
                
                print("we have a session.. setting it to UserObject of the current user")
                print("Got user: \(user1)")
                
                //UsersVM().listenForOneUser(userID: user1.uid)
                
                users_vm.listenForOneUser(user_id: user1.uid)
                stripe_accounts_vm.listenForOneStripeAccount(user_id: user1.uid)
                
                print(String(user1.uid))
                print(user1.email ?? "")
                
                self.session = UserObject(
                    uid: user1.uid,
                    email: user1.email
                )
                
            } else {
                print("No active session found. Setting AppVM.session object to nil")
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
              
              print("Authentication was successful.")
              completion(.success(result1?.user))
          }
        }
      }
    
    func signOut(users_vm: UsersVM, stripe_accounts_vm: Stripe_AccountsVM) -> Bool {
        do {
            users_vm.one_user = EmptyVariables().empty_user
            stripe_accounts_vm.one_stripe_account = EmptyVariables().empty_stripe_account
            
            try Auth.auth().signOut()
            
            self.signedIn = false
            self.session = nil
            
            

//            users_vm.one_user_listener.remove()
//            stripe_accounts_vm.one_stripe_account_listener.remove()
            
            return true
            
        } catch {
            
            return false
            
        }
    }
}
