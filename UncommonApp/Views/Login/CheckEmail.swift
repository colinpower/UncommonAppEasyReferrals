//
//  CheckEmail.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import Foundation
import SwiftUI

struct CheckEmail: View {
    
    var loginScreens1: [LoginScreens] = [.init(name: "EnterEmail", content: ""),
                                        .init(name: "CheckEmail", content: ""),
                                        .init(name: "EnterName", content: "")]
    
    @Binding var loginPath: NavigationPath
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct CheckEmail_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckEmail()
//    }
//}
