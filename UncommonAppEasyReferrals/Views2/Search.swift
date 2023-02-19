//
//  Search.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI

struct PostObject: Identifiable {

    var id = UUID().uuidString
    var timestamp: Int
    var post: Codes
    
}


struct Search: View {
    @EnvironmentObject var appData: AppDataModel
    
    
    var body: some View {
        
        
        NavigationStack {
            
            VStack {
                
                SheetHeader(title: "Search")
                
                Text("asldkfjasd")
                
                Spacer()
                
                Text("asldkfjasd")
                
                Spacer()
                
                Text("asldkfjasd")
                
                Spacer()
                
            }
            .ignoresSafeArea(.all)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            
            //MARK: Create the array joining the Discounts and the Pending Referrals together
            //let array1:[GridObject] = codes_vm.my_active_discount_codes.map { GridObject(type: "AVAILABLE", discount: $0.self, referral: emptyReferral)}


//            //MARK: Boxes: LazyVGrid for Discounts
//            LazyVGrid(columns: columns, spacing: 16) {
//
//                ForEach(array4) { gridObject in
//
//                    Button {
//
//                        selectedDiscountObject = gridObject
//
//                        if gridObject.type == "AVAILABLE" {
//                            activeSheetForMyDiscounts = .available
//                        } else {
//                            activeSheetForMyDiscounts = .pending
//                        }
//
//                    } label: {
//                        LazyVGridWidget(gridObject: gridObject)
//                    }
//                }
//
//            }
            
            
        }
        
    }
}



//MARK: SHEET HEADER
struct SheetHeader: View {
    
    var title: String
    
    var body: some View {
        HStack (alignment: .center) {
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(.black)
            Spacer()
        }.padding(.top, 48)
        .padding()
    }
}
