////
////  FRESwitcher.swift
////  UncommonApp
////
////  Created by Colin Power on 12/16/22.
////
//
//import SwiftUI
//import Firebase
//import FirebaseAuth
//
//struct FRESwitcher: View {
//    
//    @EnvironmentObject var viewModel: AppViewModel
//    
//    @ObservedObject var usersVM = UsersVM()
//    
//    @State private var email: String = ""
//    
//    var uid: String
//    
//    var body: some View {
//        
//        Group {
//            
//            let currentUserPhone = usersVM.oneUser.first?.profile.phone ?? ""
//            //let currentSessionEmail = viewModel.session?.email ?? ""
//            
//            if (currentUserPhone == "") {
//                EnterName()
//                
//            } else {
//                
//                Home(uid: uid)
//            }
//        }
//        .onAppear {
//            
//            usersVM.listenForOneUser(userID: uid)
//        }
//    }
//}
