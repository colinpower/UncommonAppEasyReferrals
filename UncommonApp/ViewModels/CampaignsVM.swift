//
//  CampaignsVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get one campaign


class CampaignsVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    
    @Published var var_getOneCampaign = [Campaigns]()
    
    func getOneCampaign() {
    
        //var ordersSnapshot = [Orders]()
    
        db.collection("campaigns")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.var_getOneCampaign = snapshot.documents.compactMap({ queryDocumentSnapshot -> Campaigns? in
                    print("AT THE TRY STATEMENT for getOneCampaign")
                    print(try? queryDocumentSnapshot.data(as: Campaigns.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Campaigns.self)
                })
            }
    
    }
    
}
