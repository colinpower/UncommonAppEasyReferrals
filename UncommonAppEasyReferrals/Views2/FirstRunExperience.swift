//
//  FirstRunExperience.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI

struct FirstRunExperience: View {
    
    @Binding var shouldShowFirstRunExperience: Bool
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Text("Welcome to Swear By!")
                
                Spacer()
                
                Text("You can add brands and products you love, and share them with your friends")
                
                Text("We make it easy to find your referral codes too, so you get credit for sharing your love")
                
                Spacer()
                
                Button {
                    @AppStorage("shouldShowFirstRunExperience") var shouldShowFirstRunExperience:Bool = false
                    shouldShowFirstRunExperience = false
                } label: {
                    Text("DONE")
                }
            }
            
        }
        
        
        
    }
}
