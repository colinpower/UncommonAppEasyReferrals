//
//  EnterEmail.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import Foundation
import SwiftUI

struct EnterEmail: View {
    
    var loginScreens1: [LoginScreens] = [.init(name: "EnterEmail", content: ""),
                                        .init(name: "CheckEmail", content: ""),
                                        .init(name: "EnterName", content: "")]
    
    @Binding var loginPath: NavigationPath
    
    var body: some View {
        VStack {
            Text("PERSONAZID")
            NavigationLink(value: loginScreens1[1]) {
                Text("asldkfjaklsdf")
            }
        }
        .navigationDestination(for: LoginScreens.self) { loginScreen in
            CheckEmail(loginPath: $loginPath)
//                    VStack {
//                        Text("loginScreen value")
//                        Text(loginScreen.name)
//                    }
        }
    }
}

//struct EnterEmail_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterEmail()
//    }
//}
