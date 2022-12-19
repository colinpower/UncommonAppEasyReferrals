//
//  UncommonAppApp.swift
//  UncommonApp
//
//  Created by Colin Power on 12/1/22.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseDynamicLinks


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct UncommonApp: App {
  
    // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
      
      let viewModel = AppViewModel()
      
    WindowGroup {
      NavigationView {
        ContentView()
          .environmentObject(viewModel)
          .preferredColorScheme(.light)
      }
    }
  }
}
