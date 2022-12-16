//
//  Start.swift
//  UncommonApp
//
//  Created by Colin Power on 12/15/22.
//

import SwiftUI

struct Start: View {
    var body: some View {
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
                Button {
                    
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Get Started")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            .padding(.vertical)
                        Spacer()
                    }
                    .background(Capsule().foregroundColor(Color("ShareGray")))
                    .padding(.horizontal).padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.15)
                }
            }
        }.ignoresSafeArea()
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}
