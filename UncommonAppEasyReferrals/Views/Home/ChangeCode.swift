//
//  ChangeCode.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/7/23.
//

import SwiftUI

struct ChangeCode: View {
    
    @ObservedObject var code_vm: CodeVM
    @ObservedObject var code_update_vm = CodeUpdateVM()
    
    //@FocusState private var keyboardFocused: Bool
    //@State private var changedCodeState: ChangedCodeState = .empty
    
    
    //@State var currentCode: String = ""
    
    @State var didTapSubmit:Bool = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            Color("Background").ignoresSafeArea()
            
            VStack {
                
                //MARK: Title + Subtitle
                Text("Change Code")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .padding(.vertical).padding(.top).padding(.top)
                    .foregroundColor(Color("text.black"))
                
                Group {
                    Text("Your current code is ")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.black"))
                    
                    + Text(code_vm.one_code.code.code)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .kerning(1.2)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
                

                //Textfield
//                HStack(alignment: .center, spacing: 16) {
//                    TextField("Enter a new code", text: $currentCode)
//                        .font(.system(size: 22, weight: .bold, design: .rounded))
//                        .kerning(1.2)
//                        .foregroundColor(getTextColor(for: changedCodeState))
//                        .limitInputLength(value: $currentCode, length: 22)
//                        .onSubmit {
//
//                            if currentCode == code_vm.one_code.code.code {
//
//                                changedCodeState = .empty
//
//                            } else if !currentCode.isEmpty {
//
//                                changedCodeState = .checking
//
//                                print("submitted")
//                                //isCheckingCode = true
//
////                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                                    changedCodeState = .failure
////                                }
//
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                    changedCodeState = .success
//                                }
//                            }
//                        }
//                        .onTapGesture(perform: {
//
//                            if changedCodeState == .empty {
//
//                            } else if changedCodeState == .checking {
//
//                            } else if changedCodeState == .success {
//                                changedCodeState = .empty
//                            } else if changedCodeState == .failure {
//                                currentCode = ""
//                                changedCodeState = .empty
//                            }
//
//                            print("tapped in the box!")
//                        })
//                        .focused($keyboardFocused)
//                        .submitLabel(.done)
//                        .keyboardType(.alphabet)
//                        .disableAutocorrection(true)
//                        .disabled(changedCodeState == .checking)
//                        .frame(height: 60)
//
//                    if changedCodeState == .empty {
//
//                        if !currentCode.isEmpty {
//                            Button {
//                                currentCode = ""
//                            } label: {
//                                Image(systemName: "xmark.circle.fill")
//                                    .font(.system(size: 20, weight: .medium))
//                                    .foregroundColor(Color.gray)
//                            }
//                        } else {
//
//                        }
//                    } else if changedCodeState == .checking {
//                        ProgressView()
//                            .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
//                            .font(.system(size: 20))
//                    } else if changedCodeState == .failure {
//                        Button {
//                            currentCode = ""
//                            changedCodeState = .empty
//                        } label: {
//                            Image(systemName: "xmark.circle.fill")
//                                .font(.system(size: 20, weight: .medium))
//                                .foregroundColor(Color.red)
//                        }
//                    } else {
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 20, weight: .medium))
//                            .foregroundColor(Color.green)
//                    }
//
//                }.frame(height: 60)

                ChangeCodeWidget(code_vm: code_vm, code_update_vm: code_update_vm, didTapSubmit: $didTapSubmit, currentCode: code_vm.one_code.code.code, shouldKeyboardBeFocused: true)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("TextFieldGray")))
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 0) {
                    Image(systemName: "exclamationmark.shield.fill")
                        .font(.system(size: 36))
                        .foregroundColor(Color.orange)
                        .padding(.trailing)
                    Text("Your old code will be replaced and will no longer work.")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color("text.black"))
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal)
        }
//        .onChange(of: didTapSubmit) { value in
//            guard value else { return }
//            didTapSubmit = false
//            print(currentCode)
//            //make request to change the code
//        }
        .onAppear {
            
            
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                keyboardFocused = true
//            }
        }
    }
}

//
//private func getTextColor(for changedCodeState: ChangedCodeState) -> Color {
//    switch (changedCodeState) {
//    case .empty: return Color("text.black")
//    case .checking: return Color("text.gray")
//    case .success: return .green
//    case .failure: return .red
//    }
//}
