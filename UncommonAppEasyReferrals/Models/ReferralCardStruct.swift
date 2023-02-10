//
//  ReferralCardStruct.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/1/23.
//

import Foundation
import SwiftUI


struct ReferralCardStruct: Identifiable {
    var id = UUID()
    var image: Image
    //var imagePreview: Image
    var text: String
    var link: String
}

extension ReferralCardStruct: Transferable {
    
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
        //ProxyRepresentation(exporting: \.imagePreview)
        //ProxyRepresentation(exporting: \.image, \.imagePreview)
    }
}
