//
//  EnterName.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import Foundation
import SwiftUI

struct EnterName: View {
    
    var setupPages: [SetupPage] = [.init(screen: "EnterPhone", content: "")]
    @State var setuppath = NavigationPath()
    
    @EnvironmentObject var viewModel: AppViewModel
    @ObservedObject var users_vm: UsersVM
    
    @State var first_name: String = ""
    @State var last_name: String = ""
    
    //var uid: String
    
    @FocusState private var firstFocused: Bool
    @FocusState private var lastFocused: Bool
    
    var body: some View {
        
        NavigationStack(path: $setuppath) {
            
            ZStack(alignment: .top) {
            
                Color("Background").ignoresSafeArea()
            
                VStack(alignment: .leading, spacing: 0) {
                    //Title
                    Text("Setup your account")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(Color("text.black"))
                        .padding(.top)
                    
                    //Subtitle
                    Text("Enter your first and last names below.")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color("text.gray"))
                        .padding(.vertical)
                        .padding(.bottom)
                    
                    //First Name textfield
                    TextField("First Name", text: $first_name)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color("text.black"))
                        .frame(height: 48)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("TextFieldGray")))
                        .onSubmit {
                            if !first_name.isEmpty {
                                
                                firstFocused = false
                                lastFocused = true
                            }
                        }
                        .focused($firstFocused)
                        .submitLabel(.next)
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .padding(.bottom)
                    
                    TextField("Last name", text: $last_name)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color("text.black"))
                        .frame(height: 48)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("TextFieldGray")))
                        .onSubmit {
                            if (!last_name.isEmpty && first_name.isEmpty) {
                                
                                firstFocused = true
                                lastFocused = false
                            } else {
                                firstFocused = false
                                lastFocused = false
                            }
                        }
                        .focused($lastFocused)
                        .submitLabel(.next)
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    //Continue button
                    Button {
                        
                        users_vm.submitNames(uid: viewModel.session?.uid ?? "", first_name: first_name, last_name: last_name)
                        
                        setuppath.append(setupPages[0])
                        
                    } label: {
                        
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Continue")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor((first_name.isEmpty || last_name.isEmpty) ? Color("text.gray") : Color.white)
                                .padding(.vertical)
                            Spacer()
                        }
                        .background(Capsule().foregroundColor((first_name.isEmpty || last_name.isEmpty) ? Color("TextFieldGray") : Color("UncommonRed")))
                        .padding(.horizontal)
                        .padding(.top).padding(.top).padding(.top)
                        
                    }.disabled((first_name.isEmpty || last_name.isEmpty))
                        
                    
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationTitle("")
            .navigationDestination(for: SetupPage.self) { page in
                EnterPhone(users_vm: users_vm, setuppath: $setuppath)
            }
            .onAppear {
                
                self.users_vm.listenForOneUserNEW(user_id: viewModel.userID ?? "USER_NOT_SET")
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    firstFocused = true
                    lastFocused = false
                }
                
                
            }
        }
    }
}

struct SetupPage: Hashable {
    
    let screen: String
    let content: String
    
}
