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
    @Published var one_shop_static = Shop(account: Shop_Account(email: "", name: Shop_Name(first: "", last: "")), campaigns: [], info: Shop_Info(category: "", description: "", domain: "", icon: "", name: "", website: ""), timestamp: Shop_Timestamp(created: 0), uuid: Shop_UUID(shop: ""))
    
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
    
    func getOneShop(shop_id: String) {
        
        let docRef = db.collection("shops").document(shop_id)

        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error)")
            }
            else {
                if let document = document {
                    do {
                        self.one_shop_static = try document.data(as: Shop.self)
                        print(self.one_shop_static)
                    }
                    catch {
                        print(error)
                    }
                }
            }
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
