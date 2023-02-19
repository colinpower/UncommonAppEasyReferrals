//
//  AddPost.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI
import PhotosUI

struct AddPost: View {
    /// - View Properties
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    var body: some View {
        NavigationStack{
            VStack{
                if let croppedImage{
                    Image(uiImage: croppedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 400)
                }else{
                    Text("No Image is Selected")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                
                NavigationLink(destination: PostDetails(croppedImage: $croppedImage)) {
                    Text("Go to next page")
                }
                
            }
            .navigationTitle("Crop Image Picker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showPicker.toggle()
                    } label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.callout)
                    }
                    .tint(.black)
                }
            }
            .cropImagePicker(
                options: [.circle,.square,.rectangle,.custom(.init(width: 350, height: 450))],
                show: $showPicker,
                croppedImage: $croppedImage
            )
        }
    }
}

