//
//  SendReferral.swift
//  UncommonApp
//
//  Created by Colin Power on 12/23/22.
//

import SwiftUI

struct SendReferral: View {
    
    @Binding var sheetContext: [String]
    
    @Binding var presentedSheet: PresentedSheet?
    
    @StateObject var membershipsVM = MembershipsVM()
    
    
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {
                
                //MARK: Top Bar
                HStack {
                    Spacer()
                    Text("Done")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .padding(.bottom)
                }.padding(.bottom)
                
                //MARK: Title + Subtitle
                Text("Share $10")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .padding(.bottom)
                Text("Send a $10 discount to your friend, and receive $20 in cash if they make a purchase with your discount code.")
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                

                CardForShareSheet(cardColor: Color("UncommonRed"), textColor: Color.white, companyName: "company name", discountAmount: "$20", discountCode: "COLIN123")
                
                Spacer()
                
                //MARK: Buttons on bottom
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("Share card")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .frame(height: 50)
                .background(Capsule().foregroundColor(Color("UncommonRed")))
                .padding(.horizontal)
                //.padding(.bottom, UIScreen.main.bounds.height * 0.1)
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("Quick Share with Messages")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("UncommonRed"))
                    Spacer()
                }
                .frame(height: 50)
                //.background(Capsule().foregroundColor(Color("UncommonRed")))
                .padding(.horizontal)
                //.padding(.bottom)
    
                
            }
            .padding()
        }
    }
}

