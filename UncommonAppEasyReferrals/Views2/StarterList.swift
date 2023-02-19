//
//  StarterList.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/18/23.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct StarterList: View {
    
    @StateObject var brand_vm = BrandViewModel()
    
    @State var added_brands:[Brand] = []
    
    var body: some View {
        
        VStack {
            
            
            ScrollView(showsIndicators: false) {
                Text("STARTER LIST")
                
                Text("Choose from a pre-selected list of popular brands. You can always add custom brands too.")
                
                
                
                ForEach(brand_vm.starter_brands) { item in
                    
                    Button {
                        if added_brands.contains(item) {
                            if let index = added_brands.firstIndex{$0 == item} {
                                added_brands.remove(at: index)
                            }
                        } else {
                            added_brands.append(item)
                        }
                    } label: {
                        TallRow(brand: item, added_brands: added_brands)
                    }
                    
                    
                }
            }
            
            starterListFooter
            
        }
        .onAppear {
            
            self.brand_vm.getStarterBrands()
            
        }
    }
    
    var starterListFooter: some View {
            
        HStack (alignment: .center) {
            
            Button {
                
                CustomerAccountsViewModel().addCustomerAccountsInBulk(brands: added_brands, user_id: "EdZzl43o5fTespxaelsTEnobTtJ2")
                
            } label: {
                
                Text("Add \(added_brands.count) brands")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
            }
            
        }.padding(.top, 48)
        .padding()
    
        
    }
    
    
}



struct TallRow: View {
    
    var brand:Brand
    var added_brands:[Brand]
    
    @State var backgroundURL:String = ""
    
    
    var body: some View {
        VStack {
            HStack {
                
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
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(brand.name)
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                        Text(brand.category)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                    }
                    
                    Spacer()
                    
                    if added_brands.contains(brand) {
                        Image(systemName: "checkmark.circle.fill")
                    } else {
                        Image(systemName: "circle")
                    }
                    
                }.padding(.top, 5)
            }
            .padding(.top, 8)
            .padding(.bottom)
        }
        .onAppear {
            
            let backgroundPath = "brands/" + brand.brand_id + "/icon.png"

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
