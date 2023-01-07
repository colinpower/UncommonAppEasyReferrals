//
//  ChangeCode.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/7/23.
//

import SwiftUI

enum ChangedCodeState: String, Identifiable {
    case empty, checking, success, failure
    var id: String {
        return self.rawValue
    }
}

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length)).replacingOccurrences(of: " ", with: "-")
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}




struct ChangeCode: View {
    
    @ObservedObject var code_vm: CodeVM
    
    @FocusState private var keyboardFocused: Bool
    
    @State var currentCode: String = ""
    
    @State private var changedCodeState: ChangedCodeState = .empty
    
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
                HStack(alignment: .center, spacing: 16) {
                    TextField("Enter a new code", text: $currentCode)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .kerning(1.2)
                        .foregroundColor(getTextColor(for: changedCodeState))
                        .limitInputLength(value: $currentCode, length: 22)
                        .onSubmit {
                            
                            if currentCode == code_vm.one_code.code.code {
                                
                                changedCodeState = .empty
                                
                            } else if !currentCode.isEmpty {
                                
                                changedCodeState = .checking
                                
                                print("submitted")
                                //isCheckingCode = true
                                
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                    changedCodeState = .failure
//                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    changedCodeState = .success
                                }
                            }
                        }
                        .onTapGesture(perform: {
                            
                            if changedCodeState == .empty {
                                
                            } else if changedCodeState == .checking {
                                
                            } else if changedCodeState == .success {
                                changedCodeState = .empty
                            } else if changedCodeState == .failure {
                                currentCode = ""
                                changedCodeState = .empty
                            }
                                
                            print("tapped in the box!")
                        })
                        .focused($keyboardFocused)
                        .submitLabel(.done)
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .disabled(changedCodeState == .checking)
                        .frame(height: 60)
                    
                    if changedCodeState == .empty {
                        
                        if !currentCode.isEmpty {
                            Button {
                                currentCode = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.gray)
                            }
                        } else {
                            
                        }
                    } else if changedCodeState == .checking {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                            .font(.system(size: 20))
                    } else if changedCodeState == .failure {
                        Button {
                            currentCode = ""
                            changedCodeState = .empty
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color.red)
                        }
                    } else {
                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.green)
                    }
                        
                }.frame(height: 60)
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                keyboardFocused = true
            }
        }
    }
}


private func getTextColor(for changedCodeState: ChangedCodeState) -> Color {
    switch (changedCodeState) {
    case .empty: return Color("text.black")
    case .checking: return Color("text.gray")
    case .success: return .green
    case .failure: return .red
    }
}
