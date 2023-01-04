//
//  CardForSnapshot.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/2/23.
//

import SwiftUI

struct CardForSnapshot: View {

    var cardColor: Color
    var textColor: Color
    
    var companyName: String
    var discountAmount: String
    var discountCode: String
    

    var body: some View {


//        VStack(alignment: .center, spacing: 0) {
            
//            GeometryReader { geometry in

                ZStack(alignment: .center) {
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(cardColor)
                        .frame(width: 320, height: 200)
                    
                    VStack(alignment: .center, spacing: 0) {
                        HStack(alignment: .center, spacing: 0) {
                            VStack(alignment: .center, spacing: 0) {
                                //Image(companyImage)
                                Text(companyName)
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .fixedSize()
                            }
                            .frame(height: 44)
                            
                            Image("fakeco1")
                                .frame(width: 40, height: 40)
                            
                            Spacer()
                            
                            Text(discountAmount)
                                .font(.system(size: 44, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .fixedSize()
                        }.padding([.top, .horizontal])
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            Text(discountCode)
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.white)
                                .fixedSize()
                            
                        }.frame(width: 200, height: 70, alignment: .center)
                        
                        Spacer()
                        
                    }.frame(width: 320, height: 200)
                }.frame(width: 320, height: 200)

//            }.padding()
//        }
        
        //.clipShape(RoundedRectangle(cornerRadius: 16)).frame(width: 320, height: 200)
    }
}

//
//struct CardForSnapshotPreview: View {
//
//    var cardColor: Color
//    var textColor: Color
//    
//    var companyName: String
//    var discountAmount: String
//    var discountCode: String
//    
//    var body: some View {
//
//
//        VStack(alignment: .center, spacing: 0) {
//            
//            Spacer()
//            
//            ZStack(alignment: .center) {
//                
//                RoundedRectangle(cornerRadius: 12)
//                    .foregroundColor(cardColor)
//                    .frame(width: 320, height: 200)
//                
//                VStack(alignment: .center, spacing: 0) {
//                    HStack(alignment: .center, spacing: 0) {
//                        VStack(alignment: .center, spacing: 0) {
//                            //Image(companyImage)
//                            Text(companyName)
//                                .font(.system(size: 12))
//                                .fontWeight(.medium)
//                                .font(.system(size: 14, weight: .medium))
//                                .foregroundColor(.white)
//                                .fixedSize()
//                        }
//                        .frame(height: 44)
//                        
//                        Image("fakeco1")
//                            .frame(width: 40, height: 40)
//                        
//                        Spacer()
//                        
//                        Text(discountAmount)
//                            .font(.system(size: 44, weight: .bold, design: .rounded))
//                            .foregroundColor(.white)
//                            .fixedSize()
//                    }.padding([.top, .horizontal])
//                    
//                    Spacer()
//                    
//                    VStack(alignment: .center, spacing: 0) {
//                        
//                        Text(discountCode)
//                            .font(.system(size: 44, weight: .bold))
//                            .foregroundColor(.white)
//                            .fixedSize()
//                        
//                    }.frame(width: 200, height: 70, alignment: .center)
//                    
//                    Spacer()
//                    
//                }.frame(width: 320, height: 200)
//            }.frame(width: 320, height: 200)
//            
//            Spacer()
//            
//        }.foregroundColor(.yellow)
//            .frame(width: 320, height: 320)
//    }
//}
