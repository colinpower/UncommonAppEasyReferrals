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


class CampaignsVM: ObservableObject, Identifiable {

    var dm = DataManager()
        
    private var db = Firestore.firestore()
    
    @Published var one_campaign = EmptyVariables().empty_campaign
    
    func getCampaign(campaign_id: String) {

        let docRef = db.collection("campaigns").document(campaign_id)

        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error)")
            }
            else {
                if let document = document {
                    do {
                        self.one_campaign = try document.data(as: Campaigns.self)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
    
}
