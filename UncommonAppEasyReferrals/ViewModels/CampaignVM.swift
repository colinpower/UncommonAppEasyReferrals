//
//  CampaignVM.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get one campaign


class CampaignVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    @Published var oneCampaign = [Campaign]()
    
    
    @Published var shop_campaigns = [Campaign]()
    
    func get_shop_campaigns(shop_id: String) {
    
        db.collection("campaigns")
            .whereField("uuid.shop", isEqualTo: shop_id)
            .getDocuments { (snapshot, error) in
    
                print("CAMPAIGNS SECTION!@!@#!#!@")
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.shop_campaigns = snapshot.documents.compactMap({ queryDocumentSnapshot -> Campaign? in
                    print("AT THE TRY FOR CAMPAIGNS")
                    print(try? queryDocumentSnapshot.data(as: Campaign.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Campaign.self)
                })
            }
    
    }
    
    
    
    
    func getCampaign() {
    
        //var ordersSnapshot = [Orders]()
        
//        print("THIS FUNCTION WAS CALLED!!!!")
    
        db.collection("campaigns")
            .getDocuments { (snapshot, error) in
    
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error")
                    return
                }
                print("Number of documents: \(snapshot.documents.count)")
    
                self.oneCampaign = snapshot.documents.compactMap({ queryDocumentSnapshot -> Campaign? in
                    print("AT THE TRY STATEMENT for THIS ONE")
                    print(try? queryDocumentSnapshot.data(as: Campaign.self) as Any)
                    return try? queryDocumentSnapshot.data(as: Campaign.self)
                })
            }
    
    }
    
}
