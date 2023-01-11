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

class MembershipVM: ObservableObject, Identifiable {
    
    //Setup
    var dm = DataManager()
    private var db = Firestore.firestore()
    
    //Published variables
    @Published var my_memberships = [Membership]()
    
    //Listeners
    var my_memberships_listener: ListenerRegistration!
    
    //Functions
    func listenForMyMemberships(uid: String) {
        
        print("got here in the request.. uid is")
        print(uid)
        
        self.my_memberships = [Membership]()
        
        self.dm.getMyMembershipsListener(uid: uid, onSuccess: { (memberships) in
            
            print("THIS IS THE MEMBERSHIPS")
            print(memberships)
            self.my_memberships = memberships
        }, listener: { (listener) in
            self.my_memberships_listener = listener
        })
    }
    
    func addMembership(shop: Shop, campaign: Campaign, user_id: String, code_id: String) {
         
        db.collection("memberships").document(user_id + "-" + shop.uuid.shop).setData([
            "campaigns": [campaign.uuid.campaign],
            "default_campaign": [
                "commission": campaign.commission.type == "FIXED" ? "$" + campaign.commission.value : campaign.commission.value + "%",
                "default_code_uuid": code_id,
                "offer": campaign.offer.type == "FIXED" ? "$" + campaign.offer.value : campaign.offer.value + "%",
                "isCash": campaign.commission.offer == "CASH",
                "uuid": campaign.uuid.campaign
            ],
            "shop": [
                "customer_id": "",
                "domain": shop.info.domain,
                "icon": shop.info.icon,
                "name": shop.info.name,
                "website": shop.info.website
            ],
            "status": "ACTIVE",
            "timestamp": [
                "created": Int(round(Date().timeIntervalSince1970)),
                "disabled": -1
            ],
            "uuid": [
                "membership": user_id + "-" + shop.uuid.shop,
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
    
    
    
//    func getMyMemberships(userId: String) {
//
//        //var ordersSnapshot = [Orders]()
//
//        db.collection("memberships")
//            .whereField("status", isEqualTo: "ACTIVE")
////            .whereField("ids.user", isEqualTo: userId)
//            .getDocuments { (snapshot, error) in
//
//                print("trying to get memberships for \(userId)")
//                guard let snapshot = snapshot, error == nil else {
//                    //handle error
//                    print("!!!!!!! found error")
//                    return
//                }
//                print("Number of documents: \(snapshot.documents.count)")
//
//                self.my_memberships = snapshot.documents.compactMap({ queryDocumentSnapshot -> Membership? in
//                    print("AT THE TRY STATEMENT for getMyMemberships")
//                    print(try? queryDocumentSnapshot.data(as: Membership.self) as Any)
//                    return try? queryDocumentSnapshot.data(as: Membership.self)
//                })
//            }
//
//    }
    
}
