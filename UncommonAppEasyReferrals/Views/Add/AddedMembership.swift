//
//  AddedMembership.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/9/23.
//

import SwiftUI

struct AddedMembership: View {
    
    var shop: Shops
    var sheetDismiss: DismissAction
    @Binding var new_code_id:String
    
    @StateObject var add_code_vm = CodesVM()
    @StateObject var add_code_updates_vm = CodeUpdatesVM()
    @Environment(\.dismiss) var dismiss
    @State var didTapSubmit:Bool = false
    
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Color("Background").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                //Title
                Text("Success!")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(Color("text.black"))
                    .padding(.top)
                
                //Subtitle
                Text("Welcome to the \(shop.shop.name) referral program!")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color("text.gray"))
                    .padding(.vertical)
                    .padding(.bottom)
                
                Text("CODE IS...")
                Text(add_code_vm.one_code.code.code)
//                Text(code_vm1.one_code.code.code)
//                
//                let myCode = code_vm1.one_code.code.code
                
                
                Group {
                    Text("Your referral code is ")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.black"))
                    
//                    + Text(code_vm1.one_code.code.code)
//                        .font(.system(size: 18, weight: .bold, design: .rounded))
//                        .kerning(1.2)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
                
                
                ChangeCodeWidget(codes_vm: add_code_vm, code_updates_vm: add_code_updates_vm, didTapSubmit: $didTapSubmit, currentCode: add_code_vm.one_code.code.code, shouldKeyboardBeFocused: false)
                                
                
                Spacer()
                
                
                //Done button
                Button {
                    sheetDismiss()
                    //dismiss()
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Done")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(Capsule().foregroundColor(Color.green))
                    .padding(.horizontal)
                }
            }.padding(.horizontal)
        }
        .onAppear {
            
            print("STARTING LISTENER FOR ")
            print(new_code_id)
            
            self.add_code_vm.listenForOneCode(code_id: new_code_id)
            //self.code_vm1.listenForOneCode(code_id: new_code_id)
            //self.code_vm1.listenForOneCode(code_id: "FCE0B513-7794-4DDD-951F-2454278C11E2")
            
            
        }
        .ignoresSafeArea(.keyboard)
    }
}
