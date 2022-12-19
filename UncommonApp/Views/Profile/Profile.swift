//
//  Profile.swift
//  UncommonApp
//
//  Created by Colin Power on 12/6/22.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("This is the profile page!")
            Spacer()
            HStack {
                Spacer()
                Button {
                    let signOutResult = viewModel.signOut()
                    
                    if !signOutResult {
                        
                        //error signing out here.. handle it somehow?
                        
                    }
                    
                } label: {
                    Text("Sign out")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.red))
                        .padding(.vertical)
                        .padding(.horizontal, 16)
                }
                Spacer()
            }.background(.white).padding(.bottom, 48)
            Spacer()
        }
        
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
