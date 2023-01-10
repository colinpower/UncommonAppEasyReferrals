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
    
//    @Binding var sheetContext: [String]
//    @Binding var presentedSheet: PresentedSheet?
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.dismiss) var dismiss
    @ObservedObject var membership_vm: MembershipVM
    @ObservedObject var code_vm: CodeVM
    
    @StateObject var campaign_vm_add = CampaignVM()
    
    var shop: Shop
    @State var didTapJoin: Bool = false  //use this var to determine whether the user already joined and pressed "Back" on the next screen
    @State private var backgroundURL: String = ""
    
    @State private var path:[Shop] = []
    
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
                                    
                                    Text(shop.info.name)
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
                        
                        
                        ForEach(campaign_vm_add.shop_campaigns) { item in
                            Text(item.domain)
                        }
                        
                        Spacer()
                        
                        //MARK: Buttons on bottom
//                        if membership_vm.my_memberships.count == 1 {
                            Button {
                                
                                //#0 create a new code ID for this user
                                if didTapJoin {
                                    path.append(shop)
                                } else {
                                    new_code_id = UUID().uuidString
                                    
                                    //#1 make request to firebase to add membership
                                    if !campaign_vm_add.shop_campaigns.isEmpty {
                                        self.membership_vm.addMembership(shop: shop, campaign: campaign_vm_add.shop_campaigns.first!, user_id: viewModel.session?.uid ?? "", code_id: new_code_id)
                                        
                                        self.code_vm.addCode(shop: shop, campaign: campaign_vm_add.shop_campaigns.first!, user_id: viewModel.session?.uid ?? "", code_id: new_code_id)
                                    }
                                    
                                    //#2 reset the code_vm listener
                                    self.code_vm.one_code = Code(code: Code_Code(code: "", color: [], graphql_id: "", is_default: false), shop: Code_Shop(domain: "", name: "", website: ""), stats: Code_Stats(usage_count: -1, usage_limit: -1), status: Code_Status(did_creation_succeed: false, status: "EMPTY"), timestamp: Code_Timestamp(created: -1, deleted: -1, used: -1), uuid: Code_UUID(campaign: "", code: "", membership: "", shop: "", user: ""))
                                    
                                    //#3 navigate to the next page
                                    path.append(shop)
                                    
                                    //#4 mark that the user attempted to join
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        didTapJoin = true
                                    }
                                }
                                
                            } label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Text(didTapJoin ? "Joined" : "Join \(shop.info.name)")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color.white)
                                    Spacer()
                                }
                                .frame(height: 50)
                                .background(Capsule().foregroundColor(didTapJoin ? Color.green : Color("UncommonRed")))
                                .padding(.horizontal)
                            }
//                        }
                    }
                }.ignoresSafeArea()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Shop.self) { shop in
                AddedMembership(code_vm: code_vm, shop: shop, sheetDismiss: dismiss, new_code_id: $new_code_id)
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
            
            self.campaign_vm_add.get_shop_campaigns(shop_id: shop.uuid.shop)
            
            let backgroundPath = shop.info.icon
            
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

//struct AddMembership_Previews: PreviewProvider {
//    static var previews: some View {
//        AddMembership(sheetContext: <#Binding<[String]>#>, presentedSheet: <#Binding<PresentedSheet?>#>)
//    }
//}
