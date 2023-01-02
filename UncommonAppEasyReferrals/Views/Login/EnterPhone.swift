//
//  EnterPhone.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import Foundation
import SwiftUI


struct TextFieldPhoneNumberModifer: ViewModifier {
    @Binding var value: String

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                
                if value.count == 1 {
                    if String($0) != "(" {
                        value = "(" + String($0)
                    }
                } else if value.count == 5 {
                    if String($0[$0.index($0.startIndex, offsetBy: 4)]) != ")" {
                        value = String($0.prefix(4)) + ")" + String($0[$0.index($0.startIndex, offsetBy: 4)])
                    }
                } else if value.count == 6 {
                    if String($0[$0.index($0.startIndex, offsetBy: 5)]) != " " {
                        value = String($0.prefix(5)) + " " + String($0[$0.index($0.startIndex, offsetBy: 5)])
                    }
                } else if value.count == 10 {
                    if String($0[$0.index($0.startIndex, offsetBy: 9)]) != "-" {
                        value = String($0.prefix(9)) + "-" + String($0[$0.index($0.startIndex, offsetBy: 9)])
                    }
                }
            }
    }
}

extension View {
    func formatPhoneNumber(value: Binding<String>) -> some View {
        self.modifier(TextFieldPhoneNumberModifer(value: value))
    }
}




struct EnterPhone: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @Binding var setuppath: NavigationPath
    
    //var uid: String
    
    @Binding var first_name: String
    @Binding var last_name: String
    
    @State var phoneNumber:String = ""
    @State var formattedPhoneNumber:String = ""             //value = String($0.prefix(length)).replacingOccurrences(of: " ", with: "-")
    //@State var verificationCodeSubmission:String = ""
    
    @State var newUUID: String = ""
    
    @FocusState private var isFocused: Bool
    
    var checkPhonePages: [CheckPhonePage] = [.init(screen: "CheckPhone", content: "")]
    
    var body: some View {
        ZStack(alignment: .top) {
        
            Color("Background").ignoresSafeArea()
        
            VStack(alignment: .leading, spacing: 0) {
                //Title
                Text("Enter your phone number")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(Color("text.black"))
                    .padding(.top)
                
                //Subtitle
                Text("We use your phone number to link your account to shops' referral programs.")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color("text.gray"))
                    .padding(.vertical)
                    .padding(.bottom)
                
                //Phone textfield
                TextField("Enter your phone number", text: $formattedPhoneNumber)
                    .formatPhoneNumber(value: $formattedPhoneNumber)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color("text.black"))
                    .frame(height: 48)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("TextFieldGray")))
                    .onSubmit {
                        //usersViewModel.requestVerificationCode(phone: phoneNumber, codeExpiresInSeconds: 180, userID: userID, verificationID: verificationID)
                        //phoneNumber = "+1" + formattedPhoneNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
                    }
                    .focused($isFocused)
                    .submitLabel(.send)
                    .keyboardType(.numberPad)
                
             
            
                
                Spacer()
                
                //Continue button
                Button {
                    
                    //send verification code
                    newUUID = UUID().uuidString
                    
                    phoneNumber = "+1" + formattedPhoneNumber.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "")
                    
                    UsersVM().requestOTP(userID: viewModel.userID ?? "", phone: phoneNumber, newUUID: newUUID)
                    
                    setuppath.append(checkPhonePages[0])
                    //                sendSignInLink()
                    //                isShowingCheckEmailView = true
                } label: {
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Send Code")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor((first_name.isEmpty || last_name.isEmpty) ? Color("text.gray") : Color.white)
                            .padding(.vertical)
                        Spacer()
                    }
                    .background(Capsule().foregroundColor((first_name.isEmpty || last_name.isEmpty) ? Color("TextFieldGray") : Color("UncommonRed")))
                    .padding(.horizontal)
                    .padding(.top).padding(.top).padding(.top)
                    
                }.disabled((first_name.isEmpty || last_name.isEmpty))
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle("")
        .navigationDestination(for: CheckPhonePage.self) { page in
            CheckPhone(setuppath: $setuppath, first_name: $first_name, last_name: $last_name, phoneNumber: $phoneNumber, newUUID: $newUUID)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                isFocused = true
            }
        }
        
        
      
        
        
        
    }
}

//struct EnterPhone_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterPhone()
//    }
//}

struct CheckPhonePage: Hashable {
    
    let screen: String
    let content: String
    
}
