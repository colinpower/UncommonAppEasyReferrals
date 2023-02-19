//
//  BrandViewModel.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class BrandViewModel: ObservableObject, Identifiable {
    
    var dm = DataManager()
    private var db = Firestore.firestore()
    
    @Published var starter_brands = [Brand]()
    
    func getStarterBrands() {
        
        db.collection("brands")
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
                
                self.starter_brands = snapshot.documents.compactMap({ queryDocumentSnapshot -> Brand? in
                    
                    print(try? queryDocumentSnapshot.data(as: Brand.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Brand.self)
                })
            }
    }
}
