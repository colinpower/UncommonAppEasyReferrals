//
//  CustomerAccountsViewModel.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class CustomerAccountsViewModel: ObservableObject, Identifiable {
    
    var dm = DataManager()
    private var db = Firestore.firestore()
    
//    @Published var my_customer_accounts = [Memberships]()
//    var my_memberships_listener: ListenerRegistration!
    
    func addCustomerAccountsInBulk(brands: [Brand], user_id: String) {
        
        for brand in brands {
            
            db.collection("customer_accounts").document(brand.brand_id + "-" + user_id).setData([
            
                "brand_id": brand.brand_id
            
            ])
            
        }
    }
    
    
    
    
//    func listenForMyMemberships(user_id: String) {
//        
//        self.my_memberships = [Memberships]()
//        
//        self.dm.getMyMembershipsListener(user_id: user_id, onSuccess: { (memberships) in
//            
//            self.my_memberships = memberships
//        }, listener: { (listener) in
//            self.my_memberships_listener = listener
//        })
//    }
    
    
    
    
}
