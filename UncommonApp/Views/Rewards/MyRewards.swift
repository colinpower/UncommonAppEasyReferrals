//
//  MyRewards.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI

struct MyRewards: View {
    
    @Binding var sheetContext: [String]
    
    @Binding var presentedSheet: PresentedSheet?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Done")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .padding(.bottom)
//                ZStack(alignment: .center) {
//                    Circle().frame(width: 28, height: 28)
//                        .foregroundColor(.gray.opacity(0.3))
//                    Image(systemName: "xmark")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                        //.foregroundColor(.gray.opacity(0.3))
////                    Image(systemName: "plus.circle.fill")
////                        .foregroundColor(.blue)
////                        .font(.title2)
//                }
            }.padding(.bottom)
            Text("Add to Wallet")
                .font(.system(size: 34, weight: .bold, design: .rounded))
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .fontDesign(.rounded)
            Text("Keep all the cards, keys, and passes you use every day all in one place")
                .font(.system(size: 18, weight: .regular))
                .padding(.vertical)
            
            HStack {
                Text("Influence")
                    .font(.title3)
//                    .fontWeight(.bold)
//                    .fontDesign(.rounded)
                    .frame(alignment: .leading)
                    .padding(.leading, 16)
                Spacer()
            }
            
            Text("Available Cards")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 8)

            HStack {
                Text("Size 24 semibold")
                    .font(.system(size: 24, weight: .semibold))
                    .frame(alignment: .leading)
                    .padding(.leading, 16)
                Spacer()
            }
            Text("Size 24 reg Tap to switch to Profile")
                .font(.system(size: 24, weight: .regular))
                .padding(.bottom, 8)
            Text("Size 16 semibold")
                .font(.system(size: 16, weight: .semibold))
                .padding(.bottom, 8)
            Text("Size 16 reg")
                .font(.system(size: 16, weight: .regular))
                .padding(.bottom, 8)
            Spacer()
        }
        .padding()
    }
}

struct MyRewards_Previews: PreviewProvider {
    static var previews: some View {
        MyRewards(sheetContext: .constant(["sdf", "sfas"]), presentedSheet: .constant(.myrewards))
    }
}
