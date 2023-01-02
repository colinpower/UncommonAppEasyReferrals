//
//  CashOut.swift
//  UncommonApp
//
//  Created by Colin Power on 12/23/22.
//

import SwiftUI

struct CashOut: View {
        
    @Binding var sheetContext: [String]
    
    @Binding var presentedSheet: PresentedSheet?
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {

                
                //MARK: Title + Subtitle
                Text("Transfer to Bank")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .padding(.vertical).padding(.top).padding(.top)
                
                Text("Transfer your balance to your bank using Stripe, our payments partner.")
                    .font(.system(size: 18, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                
                
                HStack {
                    Spacer()
                    Text("$80.00")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(Color("text.black"))
                        .padding(.bottom)
                    Spacer()
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
                .background(Capsule().foregroundColor(Color("UncommonRed")))
                .padding(.horizontal)
                //.padding(.bottom, UIScreen.main.bounds.height * 0.1)
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("View account on Stripe")
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
