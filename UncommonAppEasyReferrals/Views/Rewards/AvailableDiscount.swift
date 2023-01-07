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
    
    //@State var currentDiscountCode: String
    //@State private var didChangeCodeState: ChangedCodeState = .empty
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background").ignoresSafeArea()
                
                VStack {
                    
                    DiscountCard(cardColor: Color.blue, textColor: Color.red, commission: "$20", code: "COLIN123")
                        .padding(.vertical)
                        .padding(.bottom)
                    
                    //MARK: Title + Subtitle
                    Label {
                        Text(discount.shop.name)
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                    } icon: {
                        Image(systemName: "person.circle")
                            .font(.system(size: 34, weight: .medium, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                    }.padding(.vertical).padding(.top).padding(.top)
                    
                    Text("Use code to redeem your reward.")
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                    
//                    HStack(alignment: .center, spacing: 16) {
//                        TextField("Enter a new code", text: $currentDiscountCode)
//                            .font(.system(size: 22, weight: .bold, design: .rounded))
//                            .kerning(1.2)
//                            .foregroundColor(getTextColor(for: didChangeCodeState))
//                            .limitInputLength(value: $currentDiscountCode, length: 22)
//                            .onSubmit {
//
//                                if currentDiscountCode == code_vm.one_code.code.code {
//
//                                    changedCodeState = .empty
//
//                                } else if !currentCode.isEmpty {
//
//                                    changedCodeState = .checking
//
//                                    print("submitted")
//                                    //isCheckingCode = true
//
//    //                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    //                                    changedCodeState = .failure
//    //                                }
//
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                        changedCodeState = .success
//                                    }
//                                }
//                            }
//                            .onTapGesture(perform: {
//
//                                if changedCodeState == .empty {
//
//                                } else if changedCodeState == .checking {
//
//                                } else if changedCodeState == .success {
//                                    changedCodeState = .empty
//                                } else if changedCodeState == .failure {
//                                    currentCode = ""
//                                    changedCodeState = .empty
//                                }
//
//                                print("tapped in the box!")
//                            })
//                            .focused($keyboardFocused)
//                            .submitLabel(.done)
//                            .keyboardType(.alphabet)
//                            .disableAutocorrection(true)
//                            .disabled(changedCodeState == .checking)
//                            .frame(height: 60)
//
//                        if changedCodeState == .empty {
//
//                            if !currentCode.isEmpty {
//                                Button {
//                                    currentCode = ""
//                                } label: {
//                                    Image(systemName: "xmark.circle.fill")
//                                        .font(.system(size: 20, weight: .medium))
//                                        .foregroundColor(Color.gray)
//                                }
//                            } else {
//
//                            }
//                        } else if changedCodeState == .checking {
//                            ProgressView()
//                                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
//                                .font(.system(size: 20))
//                        } else if changedCodeState == .failure {
//                            Button {
//                                currentCode = ""
//                                changedCodeState = .empty
//                            } label: {
//                                Image(systemName: "xmark.circle.fill")
//                                    .font(.system(size: 20, weight: .medium))
//                                    .foregroundColor(Color.red)
//                            }
//                        } else {
//                            Image(systemName: "checkmark")
//                                .font(.system(size: 20, weight: .medium))
//                                .foregroundColor(Color.green)
//                        }
//
//                    }.frame(height: 60)
//                        .padding(.horizontal)
//                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("TextFieldGray")))
                    
                    Spacer()
                    
                    //MARK: Buttons on bottom
                    
                    Group {
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
                }
                .navigationTitle(discount.shop.name + " Discount")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                        }
                    }
                    
                }
        }
    }
}

