//
//  AddThingsISwearBy.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI

struct AddThingsISwearBy: View {
    
    
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                SheetHeader(title: "Add Things")
                Text("What products or brands would you swear by to your friends?")
                    .padding(.bottom)
                    .padding(.bottom)
                
                listOfOptions
                
                Text("asldkfjasd")
                
                Spacer()
                
            }
            .ignoresSafeArea(.all)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }

        
    }
    
    
    var listOfOptions: some View {
        
        VStack(spacing: 20) {
            
            NavigationLink(destination: StarterList()) {
                ThinRow_ImageTextChevron(icon: "square.fill", title: "Starter List")
            }
            
            NavigationLink(destination: StarterList()) {
                ThinRow_ImageTextChevron(icon: "star.fill", title: "Add Custom")
            }
            
            Divider()
            
            Button {
                
            } label: {
                ThinButton_ImageText(icon: "g.circle.fill", title: "Import from Gmail")
            }
            
            Button {
                
            } label: {
                ThinButton_ImageText(icon: "a.circle.fill", title: "Import from Amazon")
            }
        }
    }
}




struct ThinRow_ImageTextChevron: View {
    
    var icon: String
    var title: String
    
    var body: some View {
        
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Text(title)
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
    }
}

struct ThinButton_ImageText: View {
    
    var icon: String
    var title: String
    
    var body: some View {
        
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Text(title)
            Spacer()
            
        }
    }
}
