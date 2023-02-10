//
//  AddMembership.swift
//  UncommonApp
//
//  Created by Colin Power on 12/20/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct AddMembership: View {
    
    //Received from Home
    @ObservedObject var users_vm: UsersVM
    @ObservedObject var memberships_vm: MembershipsVM
    var shop: Shops

    //Additional listeners for view
    @Environment(\.dismiss) var dismiss
    @StateObject var add_campaign_vm = CampaignsVM()
    
    //Initialize variables for view
    @State var didTapJoin: Bool = false  //use this var to determine whether the user already joined and pressed "Back" on the next screen
    @State private var backgroundURL: String = ""
    @State private var path:[Shops] = []
    @State var new_code_id:String = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color("Background").ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //MARK: Title Section
                        ZStack(alignment: .bottom) {
                            
                            //Company's image or generic background
                            Color.yellow.frame(height: UIScreen.main.bounds.height / 4).ignoresSafeArea()
                            
                            //Company's name and icon
                            HStack(alignment: .bottom, spacing: 0) {
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    Spacer()
                                    
                                    if backgroundURL != "" {
                                        WebImage(url: URL(string: backgroundURL)!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } else {
                                        
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Text(shop.shop.name)
                                        .font(.system(size: 22, weight: .bold, design: .rounded))
                                        .foregroundColor(Color.white)
                                        .padding(.top)
                                }
                                
                                Spacer()
                                
                            }.padding(.leading).padding(.leading).padding(.bottom)
                                .frame(height: UIScreen.main.bounds.height / 4)
                        }.frame(height: UIScreen.main.bounds.height / 4)
                            .padding(.bottom)
                        
                        
                        //MARK: Referral Program Details Box
                        VStack(alignment: .leading, spacing: 0) {
                            
                            //Title: Offer
                            HStack(alignment: .bottom, spacing: 0) {
                                
                                Text("Offer")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("text.black"))
                                    .padding(.bottom, 2)
                                
                                Spacer()
                                
                            }.padding(.vertical, 10).padding(.bottom)
                            
                            //Subtitle: My Offer
                            HStack(alignment: .top, spacing: 20) {
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    Text("$10")
                                        .font(.system(size: 34, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("text.black"))
                                        .padding(.bottom, 4)
                                    
                                    Text("My friend's discount")
                                        .font(.system(size: 15, weight: .regular, design: .rounded))
                                        .foregroundColor(Color("text.gray"))
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    Text("$5")
                                        .font(.system(size: 34, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("text.black"))
                                        .padding(.bottom, 4)
                                    
                                    Text("My cash commission")
                                        .font(.system(size: 15, weight: .regular, design: .rounded))
                                        .foregroundColor(Color("text.gray"))
                                    
                                }
                                
                                Spacer()
                                
                            }
                        }.padding().padding(.bottom, 10).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.bottom)
                        
                        //MARK: Referral Program Details Box
                        VStack(alignment: .leading, spacing: 0) {
                            
                            //Title: Offer
                            HStack(alignment: .bottom, spacing: 0) {
                                
                                Text("Details")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("text.black"))
                                    .padding(.bottom, 2)
                                
                                Spacer()
                                
                            }.padding(.vertical, 10).padding(.bottom)
                            
                            StatsRow(title: "Something", value: "25")
                            StatsRow(title: "Something again", value: "$150")
                            StatsRow(title: "Something Else", value: "25")
                                .padding(.bottom, 10)
                            
                            //"See more" button
                            Button {
                                
                            } label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Text("Learn more")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color("UncommonRed"))
                                    Spacer()
                                }
                                .frame(height: 50)
                            }
                        }.padding().padding(.bottom, 10).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.bottom)
                        
                        Text("The campaign is")
                        Text(add_campaign_vm.one_campaign.uuid.campaign)
                        
                        Spacer()
                        
                        //MARK: Buttons on bottom
//                        if membership_vm.my_memberships.count == 1 {
                        
                        if didTapJoin {
                            Button {
                                path.append(shop)
                            } label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Text("Joined")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color.white)
                                    Spacer()
                                }
                                .frame(height: 50)
                                .background(Capsule().foregroundColor(Color.green))
                                .padding(.horizontal)
                            }
                        } else {
                            Button {
                                
                                self.new_code_id = UUID().uuidString
                                
                                self.memberships_vm.addMembership(shop: shop, campaign: add_campaign_vm.one_campaign, user_id: users_vm.one_user.uuid.user, code_id: new_code_id)
                                
                                CodesVM().addDefaultCode(shop: shop, campaign: add_campaign_vm.one_campaign, user_id: users_vm.one_user.uuid.user, code_id: new_code_id)
                                
                                
                                
                                //#4 mark that the user attempted to join
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    path.append(shop)
                                    didTapJoin = true
                                }
                                
                            } label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Text(didTapJoin ? "Joined" : "Join \(shop.shop.name)")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color.white)
                                    Spacer()
                                }
                                .frame(height: 50)
                                .background(Capsule().foregroundColor(didTapJoin ? Color.green : Color("UncommonRed")))
                                .padding(.horizontal)
                            }
                        }
                    }
                }.ignoresSafeArea()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Shops.self) { shop in
                AddedMembership(shop: shop, sheetDismiss: dismiss, new_code_id: $new_code_id)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("text.gray"))
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .padding(.all, 8)
                            .background(.regularMaterial, in: Circle())
                    }
                }
                
            }
        }
        .onAppear {
            
            self.add_campaign_vm.getCampaign(campaign_id: shop.campaigns.first ?? "NONE")
            
            let backgroundPath = "shops/" + shop.uuid.shop + "icon.png"
            
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
