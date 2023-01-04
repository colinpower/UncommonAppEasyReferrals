//
//  SendReferral.swift
//  UncommonApp
//
//  Created by Colin Power on 12/23/22.
//

import SwiftUI

struct SendReferral: View {
    
    //Environment
    @Environment(\.displayScale) var displayScale
    
    //State and Observed Objects
    @StateObject var membershipsVM = MembershipsVM()
    
    //Variables passed in
    @Binding var sheetContext: [String]
    @Binding var presentedSheet: PresentedSheet?
    @State private var text123 = "Your text here"
                //need to pass in the details of this specific card / program
    
    //Variables created
    @State var referralCardStruct = ReferralCardStruct(
        image: Image(systemName: "photo"),
        //imagePreview: Image(systemName: "photo"),
        text: "Use code " + "CODE" + "at Bonobos",
        link: "Or visit " + "www.google.com")
    
    @State var sharePreviewPhoto = Image(systemName: "photo")
    
    
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {
                
                //MARK: Top Bar
                HStack {
                    Spacer()
                    Text("Done")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .padding(.bottom)
                }.padding(.bottom)

                //MARK: Title + Subtitle
                Text("Share $10")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .padding(.bottom)
                Text("Send a $10 discount to your friend, and receive $20 in cash if they make a purchase with your discount code.")
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)


                CardForShareSheet(cardColor: Color("UncommonRed"), textColor: Color.white, companyName: "company name", discountAmount: "$20", discountCode: "COLIN123")
                
                
                Spacer()
                
                //MARK: Buttons on bottom
                //Share
                ShareLink(item: referralCardStruct.image,
                          message: Text(referralCardStruct.text + referralCardStruct.link),
                          //preview: SharePreview(referralCardStruct.text, image: Image(systemName: "creditcard.fill"))) {
                          preview: SharePreview(referralCardStruct.text, image: referralCardStruct.image)) {
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Share card")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(Capsule().foregroundColor(Color("UncommonRed")))
                    .padding(.horizontal)
                }
                
                //Copy
                HStack(alignment: .center) {
                    Spacer()
                    Text("Copy Discount Link")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("UncommonRed"))
                    Spacer()
                }.frame(height: 50).padding(.horizontal)

            }
            .padding()
        }
        //.onChange(of: text) { _ in render() }     //https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image
        .onAppear {
            render()
            print("appeared")
            //renderPreview()
        }
        .onDisappear {
            print("disappeared")
        }
    }
    
    @MainActor func render() {
        
        let renderer = ImageRenderer(content: CardForSnapshot(cardColor: Color("UncommonRed"), textColor: Color.white, companyName: text123, discountAmount: "$20", discountCode: "COLIN123").frame(width: 320, height: 200))

        // make sure and use the correct display scale for this device
        renderer.scale = displayScale

        if let uiImage = renderer.uiImage {
            //sharePreviewPhoto = Image(uiImage: uiImage)
            referralCardStruct.image = Image(uiImage: uiImage)
        }
    }
    
//    @MainActor func renderPreview() {
//
//        let renderer1 = ImageRenderer(content: CardForSnapshotPreview(cardColor: Color("UncommonRed"), textColor: Color.white, companyName: text123, discountAmount: "$20", discountCode: "COLIN123").frame(width: 320, height: 320))
//
//        // make sure and use the correct display scale for this device
//        renderer1.scale = displayScale
//
//        if let uiImage1 = renderer1.uiImage {
//            //sharePreviewPhoto = Image(uiImage: uiImage)
//            referralCardStruct.imagePreview = Image(uiImage: uiImage1)
//        }
//    }
    
}


struct ReferralCardStruct: Identifiable {
    var id = UUID()
    var image: Image
    //var imagePreview: Image
    var text: String
    var link: String
}

extension ReferralCardStruct: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
        //ProxyRepresentation(exporting: \.imagePreview)
        //ProxyRepresentation(exporting: \.image, \.imagePreview)
    }
}


//CardForSnapshotPreview
