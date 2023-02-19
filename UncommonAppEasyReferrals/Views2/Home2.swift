//
//  Home2.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI




struct Home2: View {
    
    @State private var presentedSheetOnHome2: PresentedSheetOnHome2? = nil
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                homeHeader
                
                if true {
                    
                    emptyState
                    
                    privacyNotice
                    
                }
                
                
                Text("asldkfjasd")
                
                Spacer()
                
            }
            .ignoresSafeArea(.all)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $presentedSheetOnHome2, onDismiss: { presentedSheetOnHome2 = nil }) { sheet in
                
                switch sheet {
                    
                case .add:
                    AddThingsISwearBy()
                case .getstarted:
                    StarterList()
                }
            }
            

        
            
            
        }
        
        
        
        
    }
    
    var homeHeader: some View {
        
        HStack (alignment: .center) {
            
            Text("What I Swear By")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(.black)
            Spacer()
            
            Button {
                
                presentedSheetOnHome2 = .add
                
            } label: {
                
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                
            }
            
        }.padding(.top, 48)
        .padding()
    }
    
    var emptyState: some View {
        
        VStack {
            HStack (alignment: .center) {
                
                Text("Add your first items")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Spacer()
                
                
            }.padding(.top, 48)
                .padding()
            
            Text("We've created a pre-set list of popular brands to help you get started.")
                .padding(.bottom)
            
            Button {
                
                presentedSheetOnHome2 = .getstarted
                
            } label: {
                
                Text("Get Started")
                
            }
        }
    }
    
    var privacyNotice: some View {
        VStack {
            HStack (alignment: .center) {
                
                Text("Items in this tab are private")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Spacer()
                
                
            }.padding(.top, 48)
                .padding()
            
            Text("None of your selected items will be shared unless you post them on your profile")
                .padding(.bottom)
            
            Button {
                
            } label: {
                
                Text("Dismiss")
                
            }
        }.background(RoundedRectangle(cornerRadius: 12).foregroundColor(.gray))
            .padding()
        
        
        
    }
    
    
    
}



//decide which view to present
enum PresentedSheetOnHome2: String, Identifiable {
    case add, getstarted
    var id: String {
        return self.rawValue
    }
}
