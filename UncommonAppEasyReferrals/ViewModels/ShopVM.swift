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
    
}
