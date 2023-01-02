//
//  ContentView.swift
//  UncommonApp
//
//  Created by Colin Power on 12/1/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    
    //Testing whether this will trigger a rebuild
    @EnvironmentObject var viewModel: AppViewModel
    
    @ObservedObject var usersViewModel = UsersVM()
    
    @State private var email: String = ""
    
    @State private var uidlisten: String = ""
    
    
    var body: some View {
        
        
        
        Group {
            
//            Home(email: .constant("colinjpower1@gmail.com"), uid: "EdZzl43o5fTespxaelsTEnobTtJ2")
            
            let currentSessionUID = viewModel.session?.uid ?? ""
            let currentSessionEmail = viewModel.session?.email ?? ""

            if (currentSessionUID != "" && currentSessionEmail != "") {

                Home(email: $email, uid: currentSessionUID)

            } else {

                Start(email: $email)

            }
      
        }
        .onAppear {
            
            viewModel.listen()
                        
        }
        .onOpenURL { url in
            let link = url.absoluteString
            
            if Auth.auth().isSignIn(withEmailLink: link) {
                viewModel.passwordlessSignIn(email1: email, link1: link) { result in
                    
                    switch result {
                    
                    case let .success(user):
                        print("inside the switch statement ")
                        print("successful !! but now starting the listener")
                        viewModel.listen()
                        
//                        Auth.auth().addStateDidChangeListener { auth, user1 in
//                           if let user1 = user1 {
//                               print("\(user1.uid) login")
//                               viewModel.signedIn = user1.isEmailVerified
//                               isShowingCheckEmailView = false
//
//                           } else {
//                               print("not login")
//                           }
//                        }
                        
                    case let .failure(error):
                        print("inside the switch statement ")
                        print("error")
                        
                        //alertItem = AlertItem(title: "An auth error occurred.", message: error.localizedDescription)
                    }
                }
            }
        }
    }
}




//how to set a background color correctly for a textfield
//https://www.devtechie.com/swiftui-textfield-background-color

//list divider color
//https://www.hackingwithswift.com/quick-start/swiftui/how-to-adjust-list-row-separator-visibility-and-color

//add variables to string
//https://stackoverflow.com/questions/30671000/how-can-i-add-variables-into-a-stringswift

//read one time from Firebase
//https://designcode.io/swiftui-advanced-handbook-read-from-firestore

//QR code
//https://www.hackingwithswift.com/books/ios-swiftui/generating-and-scaling-up-a-qr-code


//read one time from Firebase
//https://designcode.io/swiftui-advanced-handbook-read-from-firestore

//func fetchRestaurant() {
//    let db = Firestore.firestore()
//
//    let docRef = db.collection("Restaurants").document("PizzaMania")
//
//    docRef.getDocument { (document, error) in
//        guard error == nil else {
//            print("error", error ?? "")
//            return
//        }
//
//        if let document = document, document.exists {
//            let data = document.data()
//            if let data = data {
//                print("data", data)
//                self.restaurant = data["name"] as? String ?? ""
//            }
//        }
//
//    }
//}
