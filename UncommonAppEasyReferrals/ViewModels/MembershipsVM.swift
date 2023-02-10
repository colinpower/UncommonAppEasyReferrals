//
//  File.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class MembershipsVM: ObservableObject, Identifiable {
    
    //Setup
    var dm = DataManager()
    private var db = Firestore.firestore()
    
    @Published var my_memberships = [Memberships]()
    var my_memberships_listener: ListenerRegistration!
    

    func listenForMyMemberships(user_id: String) {
        
        self.my_memberships = [Memberships]()
        
        self.dm.getMyMembershipsListener(user_id: user_id, onSuccess: { (memberships) in
            
            self.my_memberships = memberships
        }, listener: { (listener) in
            self.my_memberships_listener = listener
        })
    }
    
    func addMembership(shop: Shops, campaign: Campaigns, user_id: String, code_id: String) {

        db.collection("memberships").document(user_id + "-" + shop.uuid.shop).setData([
            "campaigns": [campaign.uuid.campaign],
            "color": campaign.color,
            "default_campaign": [
                "commission": [
                    "duration_pending": campaign.commission.duration_pending,
                    "offer": campaign.commission.offer,
                    "type": campaign.commission.type,
                    "value": campaign.commission.value
                ],
                "offer": [
                    "minimum_spend": campaign.offer.minimum_spend,
                    "offer": campaign.offer.offer,
                    "one_per_customer": campaign.offer.one_per_customer,
                    "timestamp": [
                        "expires": campaign.offer.timestamp.expires,
                        "starts": campaign.offer.timestamp.starts
                    ],
                    "total_usage_limit": campaign.offer.total_usage_limit,
                    "type": campaign.offer.type,
                    "value": campaign.offer.value
                ],
                "uuid": [
                    "code": code_id,
                    "campaign": campaign.uuid.campaign
                ]
            ],
            "shop": [
                "category": shop.shop.category,
                "contact_support_email": shop.shop.contact_support_email,
                "description": shop.shop.description,
                "domain": shop.shop.domain,
                "name": shop.shop.name,
                "website": shop.shop.website
            ],
            "shopify_customer_id": "",
            "status": "ACTIVE",
            "timestamp": [
                "created": getTimestamp(),
                "disabled": 0
            ],
            "uuid": [
                "campaign": campaign.uuid.campaign,
                "cash": "",
                "code": code_id,
                "membership": user_id + "-" + shop.uuid.shop,
                "order": "",
                "referral": "",
                "reward_code": "",
                "shop": shop.uuid.shop,
                "user": user_id
            ]
        ]) { err in
            if let err = err {
                print("Error updating MEMBERSHIPS: \(err)")
            } else {
                print("Other kind of error.. idk??")
            }
        }
    }
    
    
}
