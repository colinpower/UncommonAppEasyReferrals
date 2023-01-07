//
//  ShopVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get one shop


class ShopVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    @Published var all_shops = [Shop]()
    
    func getAllShops() {
        
        db.collection("shops")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.all_shops = snapshot.documents.compactMap({ queryDocumentSnapshot -> Shop? in
                    print("AT THE TRY STATEMENT for getAllShops()")
                    print(try? queryDocumentSnapshot.data(as: Shop.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Shop.self)
                })
            }
    }
    
    
    func addShop() {

        db.collection("shops").document("ABCrb4Ps00c1HDi9wRul").setData([
                    "account": [
                        "email": "colin@alskdfjalsd",
                        "name": [
                            "first": "alkjdas",
                            "last": "asdlkfafs"
                        ]
                    ],
                    "campaigns": ["23094143", "23144390"],
                    "info": [
                        "category": "",
                        "description": "Another descriptions",
                        "domain": "google.com",
                        "icon": "shops/ABCrb4Ps00c1HDi9wRul/icon.png",
                        "name": "FakeCo",
                        "website": "google.com"
                    ],
                    "timestamp": [
                        "created": 1234
                    ],
                    "uuid": [
                        "shop": "ABCrb4Ps00c1HDi9wRul"
                    ]
                ]) { err in
                        if let err = err {
                            print("Error updating SHOPS: \(err)")
                        } else {
                            print("Other kind of error.. idk??")
                        }
                }
        }
    
    
    
    
}
