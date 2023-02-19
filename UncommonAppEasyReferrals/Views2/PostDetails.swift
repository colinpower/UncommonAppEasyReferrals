//
//  PostDetails.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI
import FirebaseStorage
import PhotosUI

struct PostDetails: View {
    
    @Binding var croppedImage: UIImage?
    
    
    @State private var caption = ""
    @State private var verifiedPurchase = ""
    @State private var sharePublicly = false
    
    var body: some View {
        
        Form {
            
            Section {
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
            }
            
            
            Section(header: Text("Caption")) {
                TextField("Why do you swear by this?", text: $caption)
            }
            
            Section(header: Text("Verified Purchase")) {
                NavigationLink(destination: SelectVerifiedPurchase(verifiedPurchase: $verifiedPurchase)) {
                    Text("Choose product")
                }
            }
            
            Section(header: Text("Visibility"), footer: sharePublicly ? Text("Everyone will be able to view your post") : Text("Only your followers will be able to see your post")) {
                Toggle("Share publicly", isOn: $sharePublicly)
                    .toggleStyle(SwitchToggleStyle())
            }
            
            
        }
        .navigationTitle("New Post")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                if croppedImage != nil {
                    Button {
                        
                        uploadPhoto()
                        
                    } label: {
                        
                        Text("Upload photo")
                        
                    }
                } else {
                    
                }
            }
        }
        
    }
    
    func uploadPhoto() {
        
        // Make sure that the selected image property isn't nil
        guard croppedImage != nil else {
            return
        }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // Turn our image into data
        let imageData = croppedImage!.pngData()
        
        //let imageData = croppedImage!.jpegData(compressionQuality: 0.8)
        
        
        
        
        guard imageData != nil else {
            print("returned nil.. trying to do it as a png instead")

            return
        }
        
        //Specify the file path and name
        let fileRef = storageRef.child("test_path3")             //let fileRef = storageRef.child("images/\(UUID().uuidstring).jpg")
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            //Check for errors
            if error == nil && metadata != nil {
                
                // TODO: Save a reference to the file in Firestore DB
                
            }
        }
        
        
        
    }
    
    
}
