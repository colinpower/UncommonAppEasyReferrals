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
    
    @EnvironmentObject var viewModel: AppViewModel
    @StateObject var users_vm = UsersVM()
    @StateObject var stripe_accounts_vm = Stripe_AccountsVM()
    
    @State private var email: String = ""
    
    @AppStorage("shouldShowFirstRunExperience")
    private var shouldShowFirstRunExperience: Bool = true
    
    var body: some View {
        
        let currentSessionUID = viewModel.session?.uid ?? ""
        let currentSessionEmail = viewModel.session?.email ?? ""
        
        Group {
            
            //if false { Home(membership_vm: membership_vm, email: .constant("colinjpower1@gmail.com"), uid: "EdZzl43o5fTespxaelsTEnobTtJ2") } else {
                
                if (currentSessionUID != "" && currentSessionEmail != "") {
                    
                    if (users_vm.one_user.profile.phone_verified) {
                        
                        //Home(users_vm: users_vm, stripe_accounts_vm: stripe_accounts_vm, email: $email)
                        
                        TabRouter()
                            .fullScreenCover(isPresented: $shouldShowFirstRunExperience, content: {
                                FirstRunExperience(shouldShowFirstRunExperience: $shouldShowFirstRunExperience)
                            })
                        
                    } else {
                        
                        EnterName(users_vm: users_vm)

                    }
                    
                } else {
                        
                    Start(users_vm: users_vm, stripe_accounts_vm: stripe_accounts_vm, email: $email)
                }
//            }
        }
        .onAppear {
            
            viewModel.listen(users_vm: users_vm, stripe_accounts_vm: stripe_accounts_vm)
            
//            @AppStorage("shouldShowFirstRunExperience") var shouldShowFirstRunExperience:Bool = true
//            shouldShowFirstRunExperience = true
                        
        }
        .onOpenURL { url in
            
            let link = url.absoluteString
            
            if Auth.auth().isSignIn(withEmailLink: link) {
                viewModel.passwordlessSignIn(email1: email, link1: link) { result in
                    
                    switch result {
                    
                    case let .success(user):
                        viewModel.listen(users_vm: users_vm, stripe_accounts_vm: stripe_accounts_vm)
                        
                    case let .failure(error):
                        print("error with result of passwordlessSignIn function")
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
