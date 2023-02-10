//
//  LoadImageFromURL.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/9/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoadImageFromURL: View {
    var body: some View {
        WebImage(url: URL(string: "https://cdn.shopify.com/s/files/1/0634/2770/7135/products/ScreenShot2022-03-20at10.15.45AM.png?v=1647789507")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 48, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing)
    }
}

struct LoadImageFromURL_Previews: PreviewProvider {
    static var previews: some View {
        LoadImageFromURL()
    }
}
