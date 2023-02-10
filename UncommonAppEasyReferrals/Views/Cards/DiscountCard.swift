////
////  CardForSnapshot.swift
////  UncommonAppEasyReferrals
////
////  Created by Colin Power on 1/2/23.
////
//
//import SwiftUI
//
//
//private extension Text {
//
//    @ViewBuilder
//    func innerShadow<V: View>(_ background: V, radius: CGFloat = 10, opacity: Double = 0.4, offsetx: Double, offsety: Double, inlaidColor: Color) -> some View {
//
//        self
//            .foregroundColor(.clear)
//            .overlay(background.mask(self))
//            .overlay(
//                ZStack {
//                    self.foregroundColor(Color(white: 1 - opacity))
//                    self.foregroundColor(inlaidColor).blur(radius: radius).offset(x:offsetx, y:offsety)
//                }
//                    .mask(self)
//                    .blendMode(.multiply)
//            )
//    }
//}
//
//
//
//struct DiscountCard: View {
//
//    var cardColor: Color
//    var textColor: Color
//    
//    var commission: String
//    var code: String
//    
//
//    var body: some View {
//        
//        VStack(alignment: .center, spacing: 0) {
//            GeometryReader { geometry in
//
//                ZStack(alignment: .center) {
//                    
//                    RoundedRectangle(cornerRadius: 12)
//                        .foregroundColor(.yellow)
//                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6)
//                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 5)
//
//                    VStack(alignment: .center, spacing: 0) {
//
//                        Spacer()
//                        
//                        Text(commission)
//                            .font(.system(size: 120, weight: .bold))
//                            .innerShadow(Color.white, radius: 2, opacity: 0.5, offsetx: 1.3, offsety: 1.3, inlaidColor: Color.yellow)
//                            .frame(alignment: .center)
//                            .fixedSize()
//                            .padding(.top, 20)
//                        
//                        Spacer()
//
//                        VStack(alignment: .center, spacing: 0) {
//
//                            Text(code)
//                                .font(.system(size: 20, weight: .bold, design: .rounded))
//                                .innerShadow(Color.white, radius: 1, opacity: 0.5, offsetx: 0.9, offsety: 0.9, inlaidColor: Color.yellow)
//                                
//                                
//                        }.frame(width: geometry.size.width, height: 20, alignment: .center)
//                            .padding(.vertical)
//
//                    }
//
//                }
//            }.padding()
//        }
//        .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width) / 1.6)
//        
//    }
//
//}
//
