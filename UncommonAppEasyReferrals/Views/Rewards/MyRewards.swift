//
//  MyRewards.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI

struct MyRewards: View {
    
    @Binding var sheetContext: [String]
    
    @Binding var presentedSheet: PresentedSheet?
    
    @StateObject var membershipsVM = MembershipsVM()
    
    let columns: [GridItem] = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2 - 32), spacing: 16, alignment: nil),
            GridItem(.fixed(UIScreen.main.bounds.width / 2 - 32), spacing: 16, alignment: nil)
        ]
    
    @State var isMyDiscountDetailPresented:Bool = false
    
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                VStack {

                    
                    //MARK: Title + Subtitle
                    Text("My Discounts")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .padding(.vertical).padding(.top).padding(.top)
                    Text("These are the discounts you've earned. Tap on a discount to use it")
                        .font(.system(size: 18, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                        .padding(.bottom)
                    
                    //MARK: Boxes: LazyVGrid for Discounts
                    LazyVGrid(columns: columns, spacing: 16) {
                                                    
                        ForEach(membershipsVM.var_getMyMemberships) { membership in
                            
                            Button {
                                isMyDiscountDetailPresented = true
                            } label: {
                                LazyVGridWidget()
                            }
                            LazyVGridWidget()
                            LazyVGridWidget()
                            LazyVGridWidget()
//                                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2 + 32)
//                                .background(.white)
//                                .clipShape(Rectangle())
                            
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            
            self.membershipsVM.getMyMemberships(userId: "EdZzl43o5fTespxaelsTEnobTtJ2")
        }
        .sheet(isPresented: $isMyDiscountDetailPresented) {
            MyDiscountDetail(isMyDiscountDetailPresented: $isMyDiscountDetailPresented)
        }
        
        
        
    }
}



struct LazyVGridWidget: View {

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //Icon
            HStack(alignment: .center, spacing: 0) {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                Spacer()
            }.padding(.bottom, 8)
            
            //Company
            Text("Bonobos")
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color("text.black"))
                .padding(.bottom)
            
            //Discount
            Text("Get $15 off any order")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(Color("text.black"))
                .frame(height: 50, alignment: .bottom)
                .multilineTextAlignment(.leading)
                .padding(.bottom)
            
            //Button
            HStack(alignment: .center) {
                Spacer()
                Text("Use")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("text.black"))
                Spacer()
            }
            .frame(height: 34)
            .background(Capsule().foregroundColor(Color("Background")))
            
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
//        .onAppear {
//
//
//        }
    }
}
