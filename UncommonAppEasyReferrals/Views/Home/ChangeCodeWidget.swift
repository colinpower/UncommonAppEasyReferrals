//
//  ChangeCodeWidget.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/9/23.
//

import SwiftUI

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


struct ChangeCodeWidget: View {
    
    @ObservedObject var codes_vm: CodesVM
    @ObservedObject var code_updates_vm: CodeUpdatesVM
    @Binding var didTapSubmit: Bool
    
    @State var currentCode: String
    
    @State var newUUID: String = ""
    var shouldKeyboardBeFocused:Bool
    
    @FocusState private var keyboardFocused: Bool
    @State private var changedCodeState: ChangedCodeState = .empty
    
    var body: some View {
        
        Text(code_updates_vm.one_code_update.status).background(.red)
        HStack(alignment: .center, spacing: 16) {
            TextField("Enter a new code", text: $currentCode)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .kerning(1.2)
                .foregroundColor(getTextColor(for: changedCodeState))
                .limitInputLength(value: $currentCode, length: 22)
                .onSubmit {
                    
                    if currentCode == codes_vm.one_code.code.code {      //if you basically didn't submit anything, ignore
                        
                        changedCodeState = .empty
                        
                    } else if !currentCode.isEmpty {                    //if it's not empty & it's different, submit an update
                        
                        let newUUID = UUID().uuidString
                        
                        code_updates_vm.addCodeUpdate(code: codes_vm.one_code, code_update_id: newUUID, new_code: currentCode)
                        
                        self.code_updates_vm.listenForOneCode(code_id: codes_vm.one_code.uuid.code, code_update_id: newUUID)

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
                        keyboardFocused = true
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
                    keyboardFocused = true
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                keyboardFocused = shouldKeyboardBeFocused
            }
            //iself.code_update_vm.listenForOneCode(code_id: codes_vm.one_code.uuid.code, code_update_id: "EMPTY")
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


enum ChangedCodeState: String, Identifiable {
    case empty, checking, success, failure
    var id: String {
        return self.rawValue
    }
}
