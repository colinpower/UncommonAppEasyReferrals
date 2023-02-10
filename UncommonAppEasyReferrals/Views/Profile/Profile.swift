//
//  Profile.swift
//  UncommonApp
//
//  Created by Colin Power on 12/6/22.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @ObservedObject var users_vm: UsersVM
    @ObservedObject var stripe_accounts_vm: Stripe_AccountsVM
    @Binding var email: String

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {
                
                //MARK: Profile Picture and Name
                Image(systemName: "person.circle")
                    .font(.system(size: 100, weight: .medium, design: .rounded))
                    .foregroundColor(Color("text.gray"))
                    .padding(.vertical).padding(.top).padding(.top)
                
                Text("Colin Power")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(Color("text.black"))
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                
                //MARK: Box: My Information
                VStack(alignment: .leading, spacing: 0) {

                    //Header
                    HStack(alignment: .bottom, spacing: 0) {

                        Text("My Info")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            .padding(.bottom, 2)
                        Spacer()
                    }.padding(.vertical, 10).padding(.bottom)

                    //List: Name, Email, Phone
                    HStack(alignment: .center, spacing: 0) {
                     
                        Text(users_vm.one_user.profile.email)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                                                
                    }.padding(.bottom)
                    
                    HStack(alignment: .center, spacing: 0) {
                     
                        Text(stripe_accounts_vm.one_stripe_account.uuid.stripe_account)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                                                
                    }.padding(.bottom)
                    
                    HStack(alignment: .center, spacing: 0) {
                     
                        Text("(617) 777 - 2994")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                                                
                    }.padding(.bottom)
                    

                }.padding()
                    .padding(.bottom, 10)
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                    .padding(.bottom)
                
                
                Spacer()
                
                //MARK: Sign Out button
                Button {
                    let signOutResult = viewModel.signOut(users_vm: users_vm, stripe_accounts_vm: stripe_accounts_vm)
                    
                    email = ""
                    
                    if !signOutResult {
                        //error signing out here.. handle it somehow?
                    }
                    
                } label: {
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Sign Out")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("UncommonRed"))
                        Spacer()
                    }
                    .frame(height: 50)
                    //.background(Capsule().foregroundColor(Color("UncommonRed")))
                    .padding(.horizontal)
                }
                
            }
            .padding()
        }
   
    }
}
