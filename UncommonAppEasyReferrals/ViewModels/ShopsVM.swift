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


class ShopsVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    @Published var all_shops = [Shops]()
    @Published var one_shop = EmptyVariables().empty_shop
    
    func getAllShops() {
        
        db.collection("shops")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.all_shops = snapshot.documents.compactMap({ queryDocumentSnapshot -> Shops? in
    
                    print(try? queryDocumentSnapshot.data(as: Shops.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Shops.self)
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
                        self.one_shop = try document.data(as: Shops.self)
                        print(self.one_shop)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
}
