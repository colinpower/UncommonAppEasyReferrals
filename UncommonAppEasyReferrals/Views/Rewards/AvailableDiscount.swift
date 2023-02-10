////
////  MyDiscountDetail.swift
////  UncommonApp
////
////  Created by Colin Power on 1/2/23.
////
//
//import SwiftUI
//
//struct AvailableDiscount: View {
//    
//    @Environment(\.dismiss) var dismiss
//    
//    @Binding var activeSheetForMyDiscounts:ActiveSheetForMyDiscounts?
//    
//    @ObservedObject var code_vm: CodeVM
//    
//    var discount: DiscountReward
//    
//    @State var isCopyTapped:Bool = false
//    @State var didTapSubmit:Bool = false
//    
//    @State var isEditingCode:Bool = false
//    @State var currentCode:String = ""
//    
//    //@State var currentDiscountCode: String
//    //@State private var didChangeCodeState: ChangedCodeState = .empty
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color("Background").ignoresSafeArea()
//                
//                VStack {
//                    
//                    DiscountCard(cardColor: Color.blue, textColor: Color.red, commission: "$20", code: "COLIN123")
//                        .padding(.vertical)
//                        .padding(.bottom)
//                    
//                    Button {
//                        
//                        isEditingCode = true
//                        currentCode = code_vm.one_code.code.code
//                        
//                    } label: {
//                        Text("EDIT CODE")
//                    }
//                    
////                    if isEditingCode {
////                        ChangeCodeWidget(code_vm: code_vm, didTapSubmit: $didTapSubmit, currentCode: currentCode, shouldKeyboardBeFocused: false)
////                    }
//                    
//                    //MARK: Title + Subtitle
//                    Label {
//                        Text(discount.shop.name)
//                            .font(.system(size: 34, weight: .bold, design: .rounded))
//                    } icon: {
//                        Image(systemName: "person.circle")
//                            .font(.system(size: 34, weight: .medium, design: .rounded))
//                            .foregroundColor(Color("text.gray"))
//                    }.padding(.vertical).padding(.top).padding(.top)
//                    
//                    Text("Use code to redeem your reward.")
//                        .font(.system(size: 16, weight: .regular))
//                        .multilineTextAlignment(.center)
//                        .padding(.bottom)
//                        .padding(.bottom)
//                        .padding(.bottom)
//                    
//                    
//                    
//                    
//                    
//                    Spacer()
//                    
//                    //MARK: Buttons on bottom
//                    
//                    Group {
//                        let discountURL = "https://" + discount.shop.domain + "/discount/" + discount.code.code + "?redirect=/collections/all"
//                        
//                        Link(destination: URL(string: discountURL)!) {
//                            HStack(alignment: .center) {
//                                Spacer()
//                                Text("Shop with Discount Link")
//                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
//                                    .foregroundColor(Color.white)
//                                Spacer()
//                            }
//                            .frame(height: 50)
//                            .background(Capsule().foregroundColor(Color("UncommonRed")))
//                            .padding(.horizontal)
//                        }
//                        
//                        Button {
//                            isCopyTapped = true
//                            UIPasteboard.general.string = discount.code.code
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                isCopyTapped = false
//                            }
//                        } label: {
//                            HStack(alignment: .center) {
//                                Spacer()
//                                Text(isCopyTapped ? "Copied to clipboard" : "Copy Code")
//                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
//                                    .foregroundColor(Color("UncommonRed"))
//                                Spacer()
//                            }
//                            .frame(height: 50)
//                            .padding(.horizontal)
//                        }
//                    }
//                }
//                .navigationTitle(discount.shop.name + " Discount")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//            .onAppear {
//                self.code_vm.listenForOneCode(code_id: discount.uuid.code)
//            }
//            .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button {
//                            dismiss()
//                        } label: {
//                            Text("Done")
//                                .font(.system(size: 17, weight: .semibold, design: .rounded))
//                                .foregroundColor(Color("text.black"))
//                        }
//                    }
//                    
//                }
//        }
//    }
//}
//
