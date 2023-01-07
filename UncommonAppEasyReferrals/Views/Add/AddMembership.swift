//
//  AddMembership.swift
//  UncommonApp
//
//  Created by Colin Power on 12/20/22.
//

import SwiftUI

struct AddMembership: View {
    
//    @Binding var sheetContext: [String]
//    @Binding var presentedSheet: PresentedSheet?
    var shop: Shop
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                VStack {
                    
                    //MARK: Top Bar
                    HStack {
                        Spacer()
                        Text("Done")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .padding(.bottom)
                    }.padding(.bottom)
                    
                    //MARK: Title + Subtitle
                    Text(shop.uuid.shop)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .padding(.bottom)
                    Text("Join a new affiliate program and add its membership to your list")
                        .font(.system(size: 18, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                        .padding(.bottom)
                    
                    //MARK: Box: Recommended Memberships
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //Header
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            Text("Recommended for you")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.bottom, 2)
                            Spacer()
                        }.padding(.vertical, 10)
                        
                        
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            Text("Based on your purchases")
                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                .foregroundColor(Color("text.gray"))
                            Spacer()
                        }.padding(.bottom, 10).padding(.bottom)
                        
                        //List of Widgets: Recommended Companies
                        Rectangle().frame(width: .infinity, height: 60).foregroundColor(.red)
                        Rectangle().frame(width: .infinity, height: 60).foregroundColor(.yellow)
                        
                    }.padding()
                        .padding(.bottom, 10)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                        .padding(.bottom)
                    
                    //MARK: Box: All Memberships
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //Header
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            Text("All affiliate programs")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.bottom, 2)
                            Spacer()
                        }.padding(.vertical, 10).padding(.bottom)
                        
                        //List of Widgets: Recommended Companies
                        Rectangle().frame(width: .infinity, height: 60).foregroundColor(.red)
                        Rectangle().frame(width: .infinity, height: 60).foregroundColor(.yellow)
                        
                    }.padding()
                        .padding(.bottom, 10)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                        .padding(.bottom)
                    
                    Spacer()
                }
                .padding()
            }
        }
        
    }
}

//struct AddMembership_Previews: PreviewProvider {
//    static var previews: some View {
//        AddMembership(sheetContext: <#Binding<[String]>#>, presentedSheet: <#Binding<PresentedSheet?>#>)
//    }
//}
