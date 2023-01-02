//
//  MyDiscountDetail.swift
//  UncommonApp
//
//  Created by Colin Power on 1/2/23.
//

import SwiftUI

struct MyDiscountDetail: View {
    
    @Binding var isMyDiscountDetailPresented:Bool
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {
                
                //MARK: Title + Subtitle
                Label {
                    Text("Bonobos")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                } icon: {
                    Image(systemName: "person.circle")
                        .font(.system(size: 34, weight: .medium, design: .rounded))
                        .foregroundColor(Color("text.gray"))
                }.padding(.vertical).padding(.top).padding(.top)
                
                Text("Use this code to redeem your reward.")
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                

                CardForShareSheet(cardColor: Color.yellow, textColor: Color.white, companyName: "company name", discountAmount: "$25", discountCode: "DISCY")
                
                Spacer()
                
                //MARK: Buttons on bottom
                HStack(alignment: .center) {
                    Spacer()
                    Text("Shop with Discount Link")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .frame(height: 50)
                .background(Capsule().foregroundColor(Color("UncommonRed")))
                .padding(.horizontal)
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("Copy Code")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("UncommonRed"))
                    Spacer()
                }
                .frame(height: 50)
                .padding(.horizontal)
                
            }
            .padding()
        }
        .onDisappear {
            isMyDiscountDetailPresented = false
        }
    }
}

