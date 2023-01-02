//
//  OrdersVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get all orders for user


class OrdersVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var var_getAllOrders = [Orders]()
    
    func getAllOrders() {
        
        db.collection("orders")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.var_getAllOrders = snapshot.documents.compactMap({ queryDocumentSnapshot -> Orders? in
                    print("AT THE TRY STATEMENT for getAllOrders")
                    print(try? queryDocumentSnapshot.data(as: Orders.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Orders.self)
                })
            }
    
    }
    
}
