//
//  SharePersonalized.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI

struct SharePersonalized: View {
    @Binding var sheetContext:[String]
    
    var body: some View {
        VStack {
            Text("PERSONAZID")
            Text(sheetContext[0])
        }
    }
}

struct SharePersonalized_Previews: PreviewProvider {
    static var previews: some View {
        SharePersonalized(sheetContext: .constant(["123", "alsdkjf"]))
    }
}
