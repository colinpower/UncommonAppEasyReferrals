//
//  Start.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import SwiftUI


struct Start: View {
    
    var enterEmailPages: [EnterEmailPage] = [.init(screen: "EnterEmail", content: "")]
    
    @ObservedObject var users_vm: UsersVM
    @ObservedObject var stripe_accounts_vm: Stripe_AccountsVM
    
    @Binding var email: String
    
    @State var startpath = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $startpath) {
            
            ZStack(alignment: .top) {
                
                Color.red.ignoresSafeArea()
                
                TabView {
                    VStack {
                        Text(users_vm.one_user.uuid.user)
                        Text(stripe_accounts_vm.one_stripe_account.uuid.stripe_account)
                    }
                    Text("Second")
                    Text("Third")
                    Text("Fourth")
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                
                VStack(alignment: .center, spacing: 0) {
                    Spacer()

                    NavigationLink(value: enterEmailPages[0]) {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Get Started")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.vertical)
                            Spacer()
                        }
                        .background(Capsule().foregroundColor(Color("ShareGray")))
                        .padding(.horizontal).padding(.horizontal)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                    }
                }
            }
            .navigationTitle("")
            .navigationDestination(for: EnterEmailPage.self) { page in
                EnterEmail(email: $email, startpath: $startpath)
            }
            .onAppear {
                print("THIS IS THE USER ACCOUND AND THE STRIPE ACCOUNT")
                print(users_vm.one_user)
                print(stripe_accounts_vm.one_stripe_account)
            }
                
        }
    }
}



struct EnterEmailPage: Hashable {
    
    let screen: String
    let content: String
    
}
