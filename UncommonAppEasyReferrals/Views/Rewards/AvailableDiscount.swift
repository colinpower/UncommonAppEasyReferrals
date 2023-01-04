//
//  MyDiscountDetail.swift
//  UncommonApp
//
//  Created by Colin Power on 1/2/23.
//

import SwiftUI

struct AvailableDiscount: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var activeSheetForMyDiscounts:ActiveSheetForMyDiscounts?
    
    var discount: DiscountReward
    
    @State var isCopyTapped:Bool = false
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {
                
                //MARK: Top Bar
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .padding(.bottom)
                    }
                }.padding(.bottom)
                
                //MARK: Title + Subtitle
                Label {
                    Text(discount.shop.name)
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
                

                CardForShareSheet(cardColor: Color.yellow, textColor: Color.white, companyName: "company name", discountAmount: "$25", discountCode: discount.code.code)
                
                Spacer()
                
                //MARK: Buttons on bottom
                let discountURL = "https://" + discount.shop.domain + "/discount/" + discount.code.code + "?redirect=/collections/all"
                
                Link(destination: URL(string: discountURL)!) {
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
                }
                
                Button {
                    isCopyTapped = true
                    UIPasteboard.general.string = discount.code.code
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isCopyTapped = false
                    }
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        Text(isCopyTapped ? "Copied to clipboard" : "Copy Code")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("UncommonRed"))
                        Spacer()
                    }
                    .frame(height: 50)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .onDisappear {
            //isMyDiscountDetailPresented = false
        }
    }
}

