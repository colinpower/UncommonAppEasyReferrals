//
//  Home.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI


//MARK: Preload
//decide which view to present
enum PresentedSheet: String, Identifiable {
    case profile, cash_out, setup_bank, mydiscounts, add, suggest
    var id: String {
        return self.rawValue
    }
}

//pass the Shop to the popup
struct ShopObject: Identifiable {
    var id = UUID().uuidString
    var shop: Shop
}


//MARK: Start
struct Home: View {

    @EnvironmentObject var viewModel: AppViewModel
    
    @StateObject var membership_vm: MembershipVM        // Home -> Detail
    @ObservedObject var code_vm = CodeVM()
    @ObservedObject var users_vm = UsersVM()
    @ObservedObject var stripe_vm = StripeVM()
    
    @StateObject var cash_reward_vm = CashRewardVM()
    @StateObject var discount_reward_vm = DiscountRewardVM()
    @StateObject var referral_vm = ReferralVM()
    @StateObject var shop_vm = ShopVM()
    
    @State private var presentedSheet: PresentedSheet? = nil
    
    @State var selectedShopObject:ShopObject = ShopObject(shop: Shop(account: Shop_Account(email: "", name: Shop_Name(first: "", last: "")), campaigns: [], info: Shop_Info(category: "", description: "", domain: "", icon: "", name: "", website: ""), timestamp: Shop_Timestamp(created: -1), uuid: Shop_UUID(shop: "")))
    
    @State var selected_shop:Shop = Shop(account: Shop_Account(email: "", name: Shop_Name(first: "", last: "")), campaigns: [], info: Shop_Info(category: "", description: "", domain: "", icon: "", name: "", website: ""), timestamp: Shop_Timestamp(created: -1), uuid: Shop_UUID(shop: ""))
    
    
    //Variables received from ContentView
    @Binding var email: String
    var uid: String
    
    
    @ViewBuilder
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .top) {
                
                Color("Background").ignoresSafeArea()
                
                ScrollView {
                    
                    //MARK: Cash and Discounts Widgets
                    HStack(alignment: .center, spacing: 16) {

                        //Cash Widget
                        Button {
                            presentedSheet = .cash_out
                        } label: {
                            cashBalanceWidget()
                        }

                        //Discounts Widget
                        Button {
                            presentedSheet = .mydiscounts
                        } label: {
                            discountsAvailableWidget(myActiveDiscounts: discount_reward_vm.my_discount_rewards, myPendingDiscounts: referral_vm.my_referrals)
                        }

                    }.padding(.vertical)
                    
                    
                    //MARK: My Brands Box
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //Header
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            Text("Brands on Uncommon App")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.bottom, 2)
                            
                            Spacer()
                            
                        }.padding(.vertical, 10)
                            .padding(.bottom)
                        
                        //First, get the list of memberships
                        let listOfMemberships = membership_vm.my_memberships.map {$0.uuid.shop}
                        let numOfNonMemberships = shop_vm.all_shops.filter { !listOfMemberships.contains($0.uuid.shop) }.count
                        
                        let filteredShops = shop_vm.all_shops.filter { !listOfMemberships.contains($0.uuid.shop) }
                        
                        ForEach(membership_vm.my_memberships) { membership in
                            
                            NavigationLink(value: membership) {
                                membershipRow(membership: membership, isLast: ((membership == membership_vm.my_memberships.last) && (numOfNonMemberships == 0)), presentedSheet: $presentedSheet)
                            }
                            
                        }
                        
                        ForEach(filteredShops) { shop in
                            
                            if !listOfMemberships.contains(shop.uuid.shop) {
                                
                                Button {
                                    selected_shop = shop
                                    selectedShopObject.shop = shop
                                    presentedSheet = .add
                                } label: {
                                    shopRow(shop: shop, isLast: (shop == filteredShops.last))
                                }
                            }
                        }
                    }.padding()
                        .padding(.bottom, 10)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                    
                    Spacer()
                    
                }.padding(.horizontal)
                .navigationTitle("")
                .navigationDestination(for: Membership.self) { membership in
                    Detail(membership: membership, code_vm: code_vm)
                }
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Image("icon.black")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .leading)
                                .padding(.trailing, 8)
                                .padding(.top, 3)
                            
                            Text("Uncommon")
                                .font(.system(size: 19, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.top, 3)
                            
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presentedSheet = .profile
                        } label: {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.top, 2)
                        }
                    }
                    
                }
                .sheet(item: $presentedSheet, onDismiss: { presentedSheet = nil }) { [selected_shop] sheet in

                    switch sheet {        //profile, cash_out, setup_bank, mydiscounts, add, suggest

                    case .profile:
                        Profile()
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .cash_out:
                        CashOut(users_vm: users_vm, stripe_vm: stripe_vm)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .setup_bank:
                        CashOut(users_vm: users_vm, stripe_vm: stripe_vm)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .mydiscounts:    //update this to MyDiscounts
                        MyDiscounts(code_vm: code_vm, myActiveDiscounts: discount_reward_vm.my_discount_rewards, myPendingDiscounts: referral_vm.my_referrals)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .add:
                        //self.code_vm.listenForOneCode(code_id: "NIL")
                        AddMembership(membership_vm: membership_vm, shop: selected_shop)
                            .presentationDetents([.large])
                            //.presentationDragIndicator(.visible)
//                    case .send:
//                        SendReferral(membership: selectedMembershipObject.membershipObject)
//                            .presentationDetents([.large])
//                            .presentationDragIndicator(.visible)
                    default:
                        MyDiscounts(code_vm: code_vm, myActiveDiscounts: discount_reward_vm.my_discount_rewards, myPendingDiscounts: referral_vm.my_referrals)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                }
                
            }
        }
        .onAppear {
            //self.cash_reward_vm.getMyCashRewards()
            self.discount_reward_vm.getMyDiscountRewards()
            self.membership_vm.listenForMyMemberships(uid: viewModel.session?.uid ?? "")
            self.referral_vm.getMyReferrals()
            self.shop_vm.getAllShops()
            self.email = ""
            self.code_vm.listenForOneCode(code_id: "NIL")
        }
    }
}


struct cashBalanceWidget: View {
    
//    @Binding var sheetContext: [String]
//    @Binding var presentedSheet: PresentedSheet?

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //Header
            HStack(alignment: .center, spacing: 0) {
                Text("Cash Balance")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("text.black"))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 11))
                    .foregroundColor(Color("text.gray"))
            }.padding(.bottom)
            
            //Content
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Text("$19.00")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        //.foregroundColor(Color("text.black"))
                        .foregroundColor(Color.green)
                        .padding(.bottom)
                    Text("$15.00 Pending")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.gray"))
                }
                Spacer()
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
//        .onAppear {
//
//
//        }
    }
}

struct discountsAvailableWidget: View {
    
    var myActiveDiscounts: [DiscountReward]
    var myPendingDiscounts: [Referral]

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //Header
            HStack(alignment: .center, spacing: 0) {
                Text("Discounts")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("text.black"))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 11))
                    .foregroundColor(Color("text.gray"))
            }.padding(.bottom)
            
            //Content
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Text(String(myActiveDiscounts.count))
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        //.foregroundColor(Color("text.black"))
                        .foregroundColor(Color.cyan)
                        .padding(.bottom)
                    Text(String(myPendingDiscounts.count) + " Pending")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.gray"))
                }
                Spacer()
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
    }
}

struct membershipRow: View {
    
    @Environment(\.displayScale) var displayScale
    @StateObject var code_vm_membershipRow = CodeVM()
    
    
    var membership: Membership
    
    
    var isLast: Bool
    
    @Binding var presentedSheet:PresentedSheet?
    
    @State var backgroundURL:String = ""
    
    //Variables created
    @State var referralCardStruct = ReferralCardStruct(
        image: Image(systemName: "photo"),
        //imagePreview: Image(systemName: "photo"),
        text: "Use code " + "CODE" + "at Bonobos",
        link: "Or visit " + "www.google.com")
    
    

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                
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
                        Text(membership.shop.name)
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                        Text("Share " + membership.default_campaign.offer + ", get " + membership.default_campaign.commission)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                    }
                    
                    Spacer()
                    
                    let codeURL = "https://" + membership.shop.domain + "/discount/" + code_vm_membershipRow.one_code_static.code.code + "?redirect=/collections/all"
                    let previewText = membership.default_campaign.offer + " at " + membership.shop.name + " with " + code_vm_membershipRow.one_code_static.code.code
                    let messageText = "Use " + code_vm_membershipRow.one_code_static.code.code + " for " + membership.default_campaign.offer + " off, or shop with this link: " + codeURL
                    let updatedImage = renderInCode(code: code_vm_membershipRow.one_code_static.code.code)
                    
                    //let testVar:ReferralCardStruct = ReferralCardStruct(image: referralCardStruct.image, text: previewText, link: messageText)
                    let referralCardObject:ReferralCardStruct = ReferralCardStruct(image: updatedImage, text: previewText, link: messageText)
                    
                    
                    ShareLink(item: referralCardObject.image,
                              message: Text(referralCardObject.link),
                              preview: SharePreview(referralCardObject.text)) {

                        Text("Send")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal)
                            .background(Capsule().foregroundColor(Color.cyan).grayscale(0.3))
                            .padding(.top, 2)
                    }
                }.padding(.top, 5)
            }
            .padding(.top, 8)
            .padding(.bottom)
                
            if !isLast {
                
                Divider().padding(.leading, 60)
                
            }
        }
        .onAppear {
            
            self.code_vm_membershipRow.getOneCode(code_id: membership.default_campaign.default_code_uuid)
            
            //render()
            
            let backgroundPath = membership.shop.icon
            
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
    
//    @MainActor func render() {
//
//        let renderer = ImageRenderer(content: ReferralCard(cardColor: .blue, textColor: .white, iconPath: membership.shop.icon, name: membership.shop.name, offer: membership.default_campaign.offer, code: code_vm.one_code.code.code, hasShadow: false))
//
//        // make sure and use the correct display scale for this device
//        renderer.scale = displayScale
//
//        if let uiImage = renderer.uiImage {
//            //sharePreviewPhoto = Image(uiImage: uiImage)
//            referralCardStruct.image = Image(uiImage: uiImage)
//        }
//    }
    
    func renderInCode(code: String) -> Image {
        
        let renderer = ImageRenderer(content: ReferralCard(cardColor: .blue, textColor: .white, iconPath: membership.shop.icon, name: membership.shop.name,offer: membership.default_campaign.offer, code: code, hasShadow: false))
        
        // make sure and use the correct display scale for this device
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            //sharePreviewPhoto = Image(uiImage: uiImage)
            //referralCardStruct.image = Image(uiImage: uiImage)
            
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.circle")
        }
    }
    
    
}

struct shopRow: View {
    
    @Environment(\.displayScale) var displayScale
    
    var shop: Shop
    var isLast: Bool
    
    @State var backgroundURL:String = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                
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
                        Text(shop.info.name)
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                        Text(shop.info.description)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                    }
                    
                    Spacer()
                    
                    
                    Text("Join")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.cyan)
                        .padding(.vertical, 6)
                        .padding(.horizontal)
                        .background(Capsule().foregroundColor(Color.gray).opacity(0.5))
                        .padding(.top, 2)
                }.padding(.top, 5)
            }
            .padding(.top, 8)
            .padding(.bottom)
                
            if !isLast {
                
                Divider().padding(.leading, 60)
            }
        }
        .onAppear {
            
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

