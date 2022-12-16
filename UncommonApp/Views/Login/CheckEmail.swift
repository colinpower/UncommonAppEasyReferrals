//
//  CheckEmail.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import Foundation
import SwiftUI

struct CheckEmail: View {
    
    @Binding var startpath: NavigationPath
    
    @Binding var email: String
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color("Background").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                //Title
                Text("Confirm your email")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(Color("text.black"))
                    .padding(.top)
                
                //Subtitle
                Text("We sent you a sign-in link. Tap it to enter Uncommon App.")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color("text.gray"))
                    .padding(.vertical)
                    .padding(.bottom)
                
                
                Spacer()
                
            }
            .padding(.horizontal)
        }
        .navigationTitle("")
        .navigationDestination(for: CheckEmailPage.self) { page in
            CheckEmail(startpath: $startpath, email: $email)
        }
    }
}

//struct CheckEmail_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckEmail()
//    }
//}
