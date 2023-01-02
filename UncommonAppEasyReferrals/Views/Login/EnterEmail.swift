//
//  EnterEmail.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import Foundation
import SwiftUI

struct EnterEmail: View {

    var checkEmailPages: [CheckEmailPage] = [.init(screen: "CheckEmail", content: "")]
    
    @Binding var startpath: NavigationPath
    
    @Binding var email: String
    
    @FocusState private var keyboardFocused: Bool

    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color("Background").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                //Title
                Text("Enter your email")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(Color("text.black"))
                    .padding(.top)
                
                //Subtitle
                Text("We'll send you a sign-in link. No passwords needed!")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color("text.gray"))
                    .padding(.vertical)
                    .padding(.bottom)
                
                //Email textfield
                TextField("", text: $email)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color("text.black"))
                    .frame(height: 48)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("TextFieldGray")))
                    .onSubmit {
                        if !email.isEmpty {
                            
                            EmailAuthVM().addEmailAuthRequest(email: email)
                            
                            startpath.append(checkEmailPages[0])
                        }
                    }
                    .focused($keyboardFocused)
                    .submitLabel(.continue)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding(.bottom)
                
                Spacer()
                
                //Continue button
                Button {
                    
                    EmailAuthVM().addEmailAuthRequest(email: email)
                    
                    startpath.append(checkEmailPages[0])
    //                sendSignInLink()
    //                isShowingCheckEmailView = true
                } label: {
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Continue")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(email.isEmpty ? Color("text.gray") : Color.white)
                            .padding(.vertical)
                        Spacer()
                    }
                    .background(Capsule().foregroundColor(email.isEmpty ? Color("TextFieldGray") : Color("UncommonRed")))
                    .padding(.horizontal)
                    .padding(.top).padding(.top).padding(.top)
                    
                }.disabled(email.isEmpty)
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle("")
        .navigationDestination(for: CheckEmailPage.self) { page in
            CheckEmail(startpath: $startpath, email: $email)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                keyboardFocused = true
            }
        }
    }
}



struct CheckEmailPage: Hashable {
    
    let screen: String
    let content: String
    
}
