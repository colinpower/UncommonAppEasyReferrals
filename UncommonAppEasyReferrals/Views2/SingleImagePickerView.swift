//
//  SingleImagePickerView.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI
import PhotosUI


//PH Picker --> NOTE.. CAN DO MULTIPLE IMAGES TOO!

struct SingleImagePickerView: View {
    
    @StateObject var imagePicker = ImagePicker()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                if let image = imagePicker.image {
                    
                    image.resizable().scaledToFit()
                    
                } else {
                    
                    Text("tap menu button to select a photo")
                }
            }
            .padding()
            .navigationTitle("Single Picker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $imagePicker.imageSelection) {
                        Image(systemName: "photo")
                            .imageScale(.large)
                    }
                }
            }
        }
        
    }
}
