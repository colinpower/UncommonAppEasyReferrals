//
//  Home.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI


struct Home: View {

    /// Receives the listeners for Users and Stripe Accounts from ContentView.
    ///
    /// - Note: email is used for logging out from the Profile page
    @ObservedObject var users_vm: UsersVM
    @ObservedObject var stripe_accounts_vm: Stripe_AccountsVM
    @Binding var email: String
    
    /// Initializes the new listeners for Memberships and Shops for the session.
    @StateObject var memberships_vm = MembershipsVM()
    @StateObject var shops_vm = ShopsVM()
    @StateObject var codes_vm = CodesVM()
    @StateObject var referrals_vm = ReferralsVM()
    
    /// Initializes the private variables for this view.
    @State private var presentedSheet: PresentedSheet? = nil
    @State private var selected_shop:Shops = EmptyVariables().empty_shop
    
    /// Returns the view for the whole Home page.
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .top) {
                
                Color("Background").ignoresSafeArea()
                
                ScrollView {
                    
                    /// Returns the views for the Cash Widget and the Discounts Widget at the top
                    HStack(alignment: .center, spacing: 16) {
 
                        Button {
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                            
                            presentedSheet = .cash_out
                        } label: {
                            CashBalanceWidget(stripe_accounts_vm: stripe_accounts_vm)
                        }

                        Button {
                            presentedSheet = .mydiscounts
                        } label: {
                            //DiscountsAvailableWidget()
                            DiscountsAvailableWidget(codes_vm: codes_vm, referrals_vm: referrals_vm)
                        }

                    }.padding(.vertical)
                    
                    
                    //MARK: My Brands Box
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //Header
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            Text("Shops on Uncommon App")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.bottom, 2)
                            
                            Spacer()
                            
                        }.padding(.vertical, 10)
                            .padding(.bottom)
                        
                        /// Creates a list of the user's active memberships and the other shops on Uncommon App where the user is not a member.
                        let listOfMemberships = memberships_vm.my_memberships.map {$0.uuid.shop}
                        let numOfNonMemberships = shops_vm.all_shops.filter { !listOfMemberships.contains($0.uuid.shop) }.count
                        let filteredShops = shops_vm.all_shops.filter { !listOfMemberships.contains($0.uuid.shop) }
                        
                        /// Loops through the active memberships and displays a row for each one.
                        ForEach(memberships_vm.my_memberships) { membership in
                            
                            NavigationLink(value: membership) {
                                
                                MembershipRow(membership: membership, isLast: ((membership == memberships_vm.my_memberships.last) && (numOfNonMemberships == 0)), presentedSheet: $presentedSheet)
                            }
                        }
                        
                        /// Loops through the other shops on Uncommon App where the user is not a member and displays a row for each one.
                        ForEach(filteredShops) { shop in
                            
                            if !listOfMemberships.contains(shop.uuid.shop) {
                                
                                Button {
                                    selected_shop = shop
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
                .navigationDestination(for: Memberships.self) { membership in
                    Detail(users_vm: users_vm, membership: membership)
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
                        Profile(users_vm: users_vm, stripe_accounts_vm: stripe_accounts_vm, email: $email)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .cash_out:
                        CashOut(users_vm: users_vm, stripe_accounts_vm: stripe_accounts_vm)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .mydiscounts:
                        MyDiscounts(users_vm: users_vm, codes_vm: codes_vm, referrals_vm: referrals_vm)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .add:
                        AddMembership(users_vm: users_vm, memberships_vm: memberships_vm, shop: selected_shop)
                            .presentationDetents([.large])
                            //.presentationDragIndicator(.visible)
//                    case .send:
//                        SendReferral(membership: selectedMembershipObject.membershipObject)
//                            .presentationDetents([.large])
//                            .presentationDragIndicator(.visible)
                    default:
                        Profile(users_vm: users_vm, stripe_accounts_vm: stripe_accounts_vm, email: $email)
                        //MyDiscounts(code_vm: code_vm, myActiveDiscounts: discount_reward_vm.my_discount_rewards, myPendingDiscounts: referral_vm.my_referrals)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                }
                
            }
        }
        .onAppear {
            
            let current_user_id = self.users_vm.one_user.uuid.user
            
            self.memberships_vm.listenForMyMemberships(user_id: current_user_id)
            self.shops_vm.getAllShops()
            
            self.codes_vm.listenForMyActiveDiscountCodes(user_id: current_user_id)
            self.referrals_vm.getMyPendingReferrals()
        }
    }
}


struct StatsRow: View {
    
    var title: String
    var value: String

    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            
            Text(title)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(Color("text.black"))
            
            Spacer()
            
            Text(value)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Color("text.black"))
            
        }
        .padding(.vertical)
    }
}

struct CashBalanceWidget: View {
    
    @ObservedObject var stripe_accounts_vm: Stripe_AccountsVM

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
                    Text("$" + String(stripe_accounts_vm.one_stripe_account.account.balance))
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        //.foregroundColor(Color("text.black"))
                        .foregroundColor(Color.green)
                        .padding(.bottom)
                    Text("$X Pending")
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

struct DiscountsAvailableWidget: View {
    
//    var myActiveDiscounts: [DiscountReward]
//    var myPendingDiscounts: [Referral]

    @ObservedObject var codes_vm: CodesVM
    @ObservedObject var referrals_vm: ReferralsVM
    
    
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
                    Text(String(codes_vm.my_active_discount_codes.count))
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        //.foregroundColor(Color("text.black"))
                        .foregroundColor(Color.cyan)
                        .padding(.bottom)
                    
                    let numOfPendingCodes = referrals_vm.my_pending_referrals.filter { $0.commission.offer != "CASH" }
                    Text(String(numOfPendingCodes.count) + " Pending")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.gray"))
                }
                Spacer()
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
    }
}

struct MembershipRow: View {

    @Environment(\.displayScale) var displayScale
    @StateObject var code_vm_membershipRow = CodesVM()

    var membership: Memberships

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
                        Text("Share " + membership.default_campaign.offer.value + ", get " + membership.default_campaign.commission.value)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                    }

                    Spacer()

                    let codeURL = "https://" + membership.shop.domain + "/discount/" + code_vm_membershipRow.one_code_static.code.code + "?redirect=/collections/all"
                    let previewText = membership.default_campaign.offer.value + " at " + membership.shop.name + " with " + code_vm_membershipRow.one_code_static.code.code
                    let messageText = "Use " + code_vm_membershipRow.one_code_static.code.code + " for " + membership.default_campaign.offer.value + " off, or shop with this link: " + codeURL
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

            self.code_vm_membershipRow.getOneCode(code_id: membership.default_campaign.uuid.code)

            //render()

            let backgroundPath = "shops/" + membership.uuid.shop + "/icon.png"
            
            print("THE SHOP UUID IS ... ")
            print(membership.uuid.shop)

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

    func renderInCode(code: String) -> Image {

        let renderer = ImageRenderer(content: ReferralCard(cardColor: .blue, textColor: .white, iconPath: membership.uuid.shop, name: membership.shop.name, offer: membership.default_campaign.offer.value, code: code, hasShadow: false))

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
    
    var shop: Shops
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
                        Text(shop.shop.name)
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .foregroundColor(.black)
                        Text(shop.shop.description)
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



/// MARK: Preload
///
/// <#Description#>
///
/// - Parameter value: <#value description#>
/// - Returns: <#return value description#>
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
    var shop: Shops
}
