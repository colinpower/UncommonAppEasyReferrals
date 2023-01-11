//
//  CashOut.swift
//  UncommonApp
//
//  Created by Colin Power on 12/23/22.
//

import SwiftUI

struct CashOut: View {
        
//    @Binding var sheetContext: [String]
//    @Binding var presentedSheet: PresentedSheet?
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var users_vm: UsersVM
    @ObservedObject var stripe_vm: StripeVM
    
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            Color.green.opacity(0.1).ignoresSafeArea()
            
            VStack {

                //MARK: Title + Subtitle
                Text("Transfer to Bank")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .padding(.vertical).padding(.top).padding(.top)
                    .foregroundColor(Color("text.black"))
                
                Text("Transfer your balance to your bank using Stripe, our payments partner.")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color("text.black"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                
                HStack {
                    Spacer()
                    Text("$80.00")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        //.foregroundColor(Color("text.black"))
                        .foregroundColor(Color.green)
                        .padding(.bottom)
                    Spacer()
                }
                
                Spacer()
                
                
                Button {
                    StripeVM().createStripeAccount(user: users_vm.one_user)
                } label: {
                    Text("TAP TO CREATE A NEW USER")
                }
                
                //Button
                let tempURL = stripe_vm.one_stripe.account.link
                
                if stripe_vm.one_stripe.account.link == "" {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Pending")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .frame(height: 34)
                    .background(Capsule().foregroundColor(Color.gray))
                } else {
                    Link(destination: URL(string: tempURL)!) {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Go to stripe")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .frame(height: 34)
                        .background(Capsule().foregroundColor(Color.cyan))
                    }
                }
                
                
                
                Spacer()
                
                
                //MARK: Buttons on bottom
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("Transfer $80")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .frame(height: 50)
                //.background(Capsule().foregroundColor(Color("text.black")))
                .background(Capsule().foregroundColor(Color.green))
                //.background(Capsule().foregroundColor(Color("UncommonRed")))
                .padding(.horizontal)
                //.padding(.bottom, UIScreen.main.bounds.height * 0.1)
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("View account on Stripe")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        //.foregroundColor(Color("UncommonRed"))
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                .frame(height: 50)
                //.background(Capsule().foregroundColor(Color("UncommonRed")))
                .padding(.horizontal)
                //.padding(.bottom)
    
                
            }
            .padding()
        }
        .onAppear {
            self.users_vm.listenForOneUserNEW(user_id: viewModel.userID ?? "")
            self.stripe_vm.listenForOneStripe(user_id: viewModel.userID ?? "")
            //self.stripe_vm.listenForOneStripe(user_id: "")
        }
        
    }
}
