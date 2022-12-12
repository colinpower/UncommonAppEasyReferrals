//
//  ReferralProgramVM.swift
//  UncommonApp
//
//  Created by Colin Power on 12/7/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class ReferralProgramVM: ObservableObject, Identifiable {
    //What arrays or data do we want to be accessible from here? Should be everything we need as it relates to RewardsPrograms
    
    @Published var referralPrograms = [ReferralProgram]()
    
    private var db = Firestore.firestore()
    
    func getReferralPrograms() {
        
        db.collection("ReferralPrograms")
            .getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                    //handle error
                    print("found error in getSnapshotOfTransactionsForCompany")
                    return
                }
                print("Number of documents: \(snapshot.documents.count ?? -1)")
                
                self.referralPrograms = snapshot.documents.compactMap({ queryDocumentSnapshot -> ReferralProgram? in
                    
                    print(try? queryDocumentSnapshot.data(as: ReferralProgram.self))
                    return try? queryDocumentSnapshot.data(as: ReferralProgram.self)
                })
            }
    }
}
