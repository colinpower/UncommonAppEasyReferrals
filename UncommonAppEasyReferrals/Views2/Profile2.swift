//
//  Profile2.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI









struct Profile2: View {


    @State private var presentedSheet: PresentedSheetOnProfile2? = nil

    
    @State var backgroundURL:String = ""

    var body: some View {

        VStack {
            Text("PROFILE")

            Spacer()

            Button {

                presentedSheet = .add

            } label: {

                Text("Add Post")
            }

            Spacer()
            
            if backgroundURL != "" {
                WebImage(url: URL(string: backgroundURL)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.trailing)
            } else {

                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 48, height: 48)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            
            
            Spacer()

            Text("FOOTER")
        }
        .sheet(item: $presentedSheet, onDismiss: { presentedSheet = nil }) { sheet in

            switch sheet {

            case .add:
//                SingleImagePickerView()
                AddPost()
                    .presentationDetents([.large])

            }
        }
        .onAppear {

            let backgroundPath = "test_path"
            
            let storage = Storage.storage().reference()

            storage.child(backgroundPath).downloadURL { url, err in
                if err != nil {
                    print(err?.localizedDescription ?? "Issue showing the right image")
                    return
                } else {
                    self.backgroundURL = "\(url!)"
                }
            }
        }



    }
}


//decide which view to present
enum PresentedSheetOnProfile2: String, Identifiable {
    case add
    var id: String {
        return self.rawValue
    }
}
