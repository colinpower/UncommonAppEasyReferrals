//
//  ContentView.swift
//  UncommonApp
//
//  Created by Colin Power on 12/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
        
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
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




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
