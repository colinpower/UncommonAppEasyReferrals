//
//  CompaniesVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get one company


class CompaniesVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var var_getAllCompanies = [Companies]()
    
    func getAllCompanies() {
    
        //var ordersSnapshot = [Orders]()
    
        db.collection("companies")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.var_getAllCompanies = snapshot.documents.compactMap({ queryDocumentSnapshot -> Companies? in
                    print("AT THE TRY STATEMENT for getAllCompanies")
                    print(try? queryDocumentSnapshot.data(as: Companies.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Companies.self)
                })
            }
    
    }
    
}
