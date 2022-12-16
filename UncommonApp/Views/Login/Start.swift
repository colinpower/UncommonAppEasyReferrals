//
//  Start.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import SwiftUI

struct Start: View {
    
    //var loginScreens: [LoginScreens] = [.init(name: "EnterEmail", content: ""),
//                                        .init(name: "CheckEmail", content: ""),
//                                        .init(name: "EnterName", content: "")]
    
    //@State var path = NavigationPath()
    
    var body: some View {
        //NavigationStack(path: $path) {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.red
                TabView {
                    Text("First")
                    Text("Second")
                    Text("Third")
                    Text("Fourth")
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
//                    Button {
//                        path.append(loginScreens[0])
//                    } label: {
//                        Text("Get started")
//                    }
                    Spacer()
                    
                    NavigationLink {
                        EnterEmail()
                    } label: {
                        Text("Get Started")
                    }

                    
//                    NavigationLink(value: loginScreens[1]) {
//                        Text("asldkfjaklsdf")
//                    }
                    Spacer()
                    
                    
//                    Button {
//
//                    } label: {
//                        HStack(alignment: .center) {
//                            Spacer()
//                            Text("Get Started")
//                                .font(.system(size: 20, weight: .semibold, design: .rounded))
//                                .foregroundColor(Color("text.black"))
//                                .padding(.vertical)
//                            Spacer()
//                        }
//                        .background(Capsule().foregroundColor(Color("ShareGray")))
//                        .padding(.horizontal).padding(.horizontal)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.15)
//                    }
                    
                    
                }
            }.ignoresSafeArea()
//                .navigationDestination(for: LoginScreens.self) { loginScreen in
//                    EnterEmail(loginPath: $path)
////                    VStack {
////                        Text("loginScreen value")
////                        Text(loginScreen.name)
////                    }
//                }
        }
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}



struct LoginScreens: Hashable {
    
    let name: String
    let content: String
}
