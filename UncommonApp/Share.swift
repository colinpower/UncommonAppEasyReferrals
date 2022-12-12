//
//  Share.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI

struct Share: View {
    
    @Binding var sheetContext:[String]
    
    var body: some View {
        Text(sheetContext[0])
    }
}

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share(sheetContext: .constant(["test", "sadlfk"]))
    }
}
