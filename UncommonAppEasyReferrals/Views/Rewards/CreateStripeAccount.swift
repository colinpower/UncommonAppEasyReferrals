//
//  CreateStripeAccount.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/7/23.
//

import SwiftUI

struct CreateStripeAccount: View {
    
    
    @ObservedObject var stripe_accounts_vm: Stripe_AccountsVM
    
    
    var body: some View {
        
        VStack {
           
            
            let setupLink = stripe_accounts_vm.one_stripe_account.setup.link
            
            if setupLink == "" {
                ProgressView()
            } else {
                Link(destination: URL(string: setupLink)!) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Setup Account.. link to stripe")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .frame(height: 34)
                    .background(Capsule().foregroundColor(Color.cyan))
                }
            }
            
            
            
        }
        
    }
}
