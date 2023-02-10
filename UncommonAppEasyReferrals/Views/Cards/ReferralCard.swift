//
//  CardForShareSheet.swift
//  UncommonApp
//
//  Created by Colin Power on 12/31/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct ReferralCard: View {


    var cardColor: Color
    var textColor: Color
    
    var iconPath: String
    var name: String
    var offer: String
    var code: String
    
    var hasShadow:Bool

    @State var backgroundURL:String = ""

    var body: some View {

            VStack(alignment: .center, spacing: 0) {
                GeometryReader { geometry in

                    ZStack(alignment: .center) {
                        
                        if hasShadow {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(cardColor)
                                .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                                .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 5)
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(cardColor)
                                .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
                        }

                        VStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .center, spacing: 0) {
                                
                                if hasShadow {
                                    
                                    if backgroundURL != "" {
                                        WebImage(url: URL(string: backgroundURL)!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 32, height: 32)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .padding(.trailing, 6)
                                    } else {
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 32, height: 32)
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 6)
                                    }
                                } else {
//                                        Image("fakeco1")
//                                            .frame(width: 40, height: 40)
//                                    Image("icon.black")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 24, height: 24)
//                                        .padding(.trailing, 6)
                                }
                                
                                Text(name)
                                    .font(.system(size: 20, weight: .medium, design: .rounded))
                                    .foregroundColor(textColor)

                                Spacer()

                            }.padding([.top, .horizontal])

                            Spacer()
                            
                            Text(offer)
                                .font(.system(size: 72, weight: .bold, design: .rounded))
                                .foregroundColor(textColor)
                                .frame(alignment: .center)
                            
                            Spacer()

                            VStack(alignment: .center, spacing: 0) {

                                Text("Use code ")
                                    .font(.system(size: 20, weight: .medium, design: .rounded))
                                    .foregroundColor(textColor)
                                + Text(code)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(textColor)
                                    
                            }.frame(width: geometry.size.width, height: 20, alignment: .center)
                                .padding(.vertical)

                        }

                    }
                }.padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width) / 1.6)
            .onAppear {
                
                let backgroundPath = iconPath
                
                let storage = Storage.storage().reference()
                
                storage.child(backgroundPath).downloadURL { url, err in
                    if err != nil {
                        print(err?.localizedDescription ?? "Issue showing the right image")
                        return
                    } else {
                        self.backgroundURL = "\(url!)"
                    }
                }
            }

    }
}
