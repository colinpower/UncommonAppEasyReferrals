//
//  Share.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI

struct Share: View {
    
    @Binding var sheetContext:[String]
    
    var body: some View {
        Text(sheetContext[0])
    }
}

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share(sheetContext: .constant(["test", "sadlfk"]))
    }
}



//
////
////  CardForLoyaltyProgram.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 9/6/22.
////
//
//import SwiftUI
//
//struct CardForLoyaltyProgram: View {
//    
//    var discountCode:DiscountCodes?
//    
//    var cardColor:Color
//    var textColor:Color
//    
//    var companyImage:String = "AthleisureLA-Icon-Teal"
//    var companyName:String
//    
//    var currentDiscountAmount:String
//    var currentDiscountCode:String
//    
//    var userFirstName:String
//    var userLastName:String
//    
//    var userCurrentTier:String
//    
//    var discountCardDescription:String   //e.g. "Default Card"
//    
//    
////    var cardColor:String = "Background" //"Gold1"
////    var textColor:String = "white" //"GoldInlaid"
//    
//    
//    
//    
//    
//    var body: some View {
//        VStack(alignment: .center, spacing: 0) {
//            GeometryReader { geometry in
//                
//                ZStack(alignment: .center) {
//                    
//                    RoundedRectangle(cornerRadius: 16)
//                        .foregroundColor(cardColor)
//                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
//                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 5)
//                    
//                    VStack(alignment: .center, spacing: 0) {
//                        HStack(alignment: .center, spacing: 0) {
//                            VStack(alignment: .center, spacing: 0) {
//                                //Image(companyImage)
//                                Image(companyImage)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 60, height: 30, alignment: .leading)
//                                    .padding(.bottom, 2)
//                                Text(companyName)
//                                    .font(.system(size: 12))
//                                    .fontWeight(.medium)
//                                    .font(.system(size: 14, weight: .medium))
//                                    .innerShadow(cardColor, radius: 1, opacity: 0.5, offsetx: 0.9, offsety: 0.9, inlaidColor: textColor)
//                                    .fixedSize()
//                            }
//                            .frame(height: 44)
//                            
//                            Spacer()
//                            
//                            Text(currentDiscountAmount)
//                                .font(.system(size: 44, weight: .bold, design: .rounded))
//                                .innerShadow(cardColor, radius: 1.5, opacity: 0.5, offsetx: 1, offsety: 1, inlaidColor: textColor)
//                                .fixedSize()
//                        }.padding([.top, .horizontal])
//                        
//                        Spacer()
//                        
//                        VStack(alignment: .center, spacing: 0) {
//                            
//                            Text(currentDiscountCode)
//                                .font(.system(size: 44, weight: .bold))
//                                .innerShadow(cardColor, radius: 1.5, opacity: 0.5, offsetx: 1, offsety: 1, inlaidColor: textColor)
//                                .fixedSize()
//                                //.foregroundColor(textColor)
//                            Text("PERSONAL DISCOUNT CODE")
//                                .font(.system(size: 14, weight: .medium))
//                                .innerShadow(cardColor, radius: 1, opacity: 0.5, offsetx: 0.9, offsety: 0.9, inlaidColor: textColor)
//                                .fixedSize()
//                            
//                            
//                        }.frame(width: geometry.size.width, height: 70, alignment: .center)
//                        
//                        Spacer()
//                        
//                        HStack(alignment: .bottom, spacing: 0) {
//                            
//                            VStack(alignment: .leading, spacing: 0) {
//                                Text(userFirstName + " Power")
//                                    .font(.system(size: 20, weight: .medium))
//                                    .innerShadow(cardColor, radius: 1.2, opacity: 0.5, offsetx: 1, offsety: 1, inlaidColor: textColor)
//                                    .fixedSize()
//                                
//                                
//                            }.frame(height: 38)
//                            
//                            Spacer()
//                        }
//                        .frame(height: 38)
//                        .padding([.bottom, .horizontal])
//
//                    }
//                    
//                    
//                }
//            }.padding()
//        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.6)
//    }
//}
//
//private extension Text {
//    
//    func innerShadow<V: View>(_ background: V, radius: CGFloat = 1, opacity: Double = 0.5, offsetx: Double, offsety: Double, inlaidColor: Color) -> some View {
//        
//        self
//            .foregroundColor(.clear)
//            .overlay(background.mask(self))
//            .overlay(
//                ZStack {
////                    self.foregroundColor(Color(white: 1 - opacity))
//                    self.foregroundColor(Color(white: 1 - opacity))
//                    //self.foregroundColor(Color("GoldInlaidText")).blur(radius: 3).offset(x:1.5,y:1.5)
//                    self.foregroundColor(inlaidColor).blur(radius: radius).offset(x:offsetx, y:offsety)
//                    
////                    self.foregroundColor(Color("GoldShadow").opacity(0.5))
////                    self.foregroundColor(Color("GoldShadow")).blur(radius: 2) //.offset(x:0.3,y:0.3)
//                }
//                    .mask(self)
//                    .blendMode(.multiply)
//            )
//    }
//}
