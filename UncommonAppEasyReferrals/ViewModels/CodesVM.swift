//
//  CodesVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

//Required Queries
    // Get one code


class CodesVM: ObservableObject, Identifiable {

    var dm = DataManager()
    private var db = Firestore.firestore()
    

    @Published var one_code = EmptyVariables().empty_code {
        didSet {
            print("updated the one_code variable.. here it is...")
            print(one_code)
        }
    }
    @Published var one_code_static = EmptyVariables().empty_code
    @Published var my_active_discount_codes = [Codes]()
    
    var one_code_listener: ListenerRegistration!
    var my_active_discount_codes_listener: ListenerRegistration!
        
    func getOneCode(code_id: String) {

        let docRef = db.collection("codes").document(code_id)

        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error)")
            }
            else {
                if let document = document {
                    do {
                        self.one_code_static = try document.data(as: Codes.self)
                        print(self.one_code_static)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    func listenForOneCode(code_id: String) {
        
        if (code_id.isEmpty) {
            print("CODE WAS EMPTY")
            return
        } else {
            
            self.dm.getOneCodeListener(code_id: code_id, onSuccess: { (code) in
                
                self.one_code = code
                
                print("FOUND ONE CODE")
                print(self.one_code)
                
            }, listener: { (listener) in
                self.one_code_listener = listener
            })
        }
    }
    
    func listenForMyActiveDiscountCodes(user_id: String) {
            
        self.dm.getMyActiveDiscountCodesListener(user_id: user_id, onSuccess: { (codes) in
            
            self.my_active_discount_codes = codes
            
            print("FOUND MY DISCOUNT CODES CODE")
            print(self.my_active_discount_codes)
            
        }, listener: { (listener) in
            self.my_active_discount_codes_listener = listener
        })
    }
    
    func addDefaultCode(shop: Shops, campaign: Campaigns, user_id: String, code_id: String, code: String = "") {
         
        db.collection("codes").document(code_id).setData([
            "_PURPOSE": "REFERRAL",
            "code": [
                "code": code,
                "UPPERCASED": code.uppercased(),
                "color": [255, 255, 255],
                "graphql_id": "",
                "is_default": true
            ],
            "shop": [
                "category": shop.shop.category,
                "contact_support_email": shop.shop.contact_support_email,
                "description": shop.shop.description,
                "domain": shop.shop.domain,
                "name": shop.shop.name,
                "website": shop.shop.website
            ],
            "stats": [
                "usage_count": 0,
                "usage_limit": campaign.offer.total_usage_limit
            ],
            "status": "ACTIVE",
            "timestamp": [
                "created": 0,
                "deleted": -1,
                "last_used": -1,
                "pending": getTimestamp()
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
                print("Error creating CODE: \(err)")
            } else {
                print("Other kind of error.. idk??")
            }
        }
    }
    
    
    
    
}
