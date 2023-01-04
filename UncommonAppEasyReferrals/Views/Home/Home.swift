//
//  Home.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI


//MARK: Decide which sheet to present
enum PresentedSheet: String, Identifiable {
    case profile, cash_out, setup_bank, myrewards, add, send
    var id: String {
        return self.rawValue
    }
}


//how to do NavigationPath
//https://www.youtube.com/watch?v=oxp8Qqwr4AY


struct Home: View {
        
    @EnvironmentObject var viewModel: AppViewModel
    
    @StateObject var campaign_vm = CampaignVM()
    @StateObject var code_vm = CodeVM()
    @StateObject var membership_vm = MembershipVM()
    @StateObject var referral_vm = ReferralVM()
    @StateObject var shop_vm = ShopVM()
    @StateObject var cash_reward_vm = CashRewardVM()
    @StateObject var discount_reward_vm = DiscountRewardVM()
    
    
    
    @ObservedObject var ordersVM = OrdersVM()
    
    //@ObservedObject var rewardsVM = RewardsVM()
    @ObservedObject var usersVM = UsersVM()
    
    
    @State var sheetContext = ["NONE", "fdasdf"]
    
    @State private var presentedSheet: PresentedSheet? = nil
    
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
                            cashBalanceWidget(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                        }

                        //Discounts Widget
                        Button {
                            presentedSheet = .myrewards
                        } label: {
                            discountsAvailableWidget(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                        }

                    }.padding(.vertical)
                    
                    
                    //MARK: My Brands Box
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //Header
                        HStack(alignment: .bottom, spacing: 0) {
                            
                            Text("My Brands")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.bottom, 2)
                            
                            Spacer()
                            
                            Button {
                                presentedSheet = .add
                            } label: {
                                
                                Text("Add")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color("text.black"))
                                    .padding(.vertical, 4)
                                    .padding(.horizontal)
                                    .background(Capsule().foregroundColor(Color("ShareGray").opacity(0.3)))
                            }
                        }.padding(.vertical, 10)
                            .padding(.bottom)
                        
                        //Rows of Current Memberships
                        ForEach(membership_vm.my_memberships) { membership in
 
                            NavigationLink(value: membership) {
                                
                                programRow(membership: membership, title: membership.shop.name, isLast: membership == membership_vm.my_memberships.last, sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            }
                        }
                        
                    }.padding()
                        .padding(.bottom, 10)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                    
                    //MARK: NEED TO ADD A "ADD MEMBERSHIPS BUTTON"
                    
                    Spacer()
                    
                }.padding(.horizontal)
                .navigationTitle("")
                .navigationDestination(for: Membership.self) { membership in
                    Detail(membership: membership)
                }
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Image("icon.black")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22, alignment: .leading)
                                .padding(.trailing, 8)
                                .padding(.top, 2)
                            
                            Text("Uncommon")
                                .font(.system(size: 21, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.top, 2)
                            
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presentedSheet = .profile
                        } label: {
                            Image(systemName: "person.circle")
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.top, 5)
                        }
                    }
                    
                }
                .sheet(item: $presentedSheet, onDismiss: { presentedSheet = nil }) { [sheetContext] sheet in
                    
                    switch sheet {        //profile, cash_out, setup_bank, myrewards, add, send
                    
                    case .profile:
                        Profile(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .cash_out:
                        CashOut(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .setup_bank:
                        CashOut(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .myrewards:
                        MyRewards(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .add:
                        AddMembership(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .send:
                        SendReferral(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    default:
                        MyRewards(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                        //ReviewProductCarousel1(activeReviewOrReferSheet: $activeReviewOrReferSheet, item: item)
                    }
                }
                
            }
        }
        .onAppear {
            
            self.membership_vm.getMyMemberships(userId: "EdZzl43o5fTespxaelsTEnobTtJ2")
            
            //self.campaign_vm.getCampaign()
            self.code_vm.getOneCode(codeId: "")
            
            self.referral_vm.getMyReferrals()
            //self.cash_reward_vm.getMyCashRewards()
            self.discount_reward_vm.getMyDiscountRewards()
            
            self.shop_vm.getAllShops()

            self.usersVM.listenForOneUser(userID: uid)
            
            self.email = ""
            
            print("trying to print the current session")
            print(self.viewModel.session?.email)
            print(self.viewModel.session?.uid)
        }
    }
}


struct cashBalanceWidget: View {
    
    @Binding var sheetContext: [String]
    @Binding var presentedSheet: PresentedSheet?

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
    
    @Binding var sheetContext: [String]
    @Binding var presentedSheet: PresentedSheet?

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
                    Text("4")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        //.foregroundColor(Color("text.black"))
                        .foregroundColor(Color.cyan)
                        .padding(.bottom)
                    Text("0 Pending")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.gray"))
                }
                Spacer()
            }
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
        .onAppear {

            print("appeared HOME")
        }
    }
}





struct programRow: View {
    
    var membership: Membership = Membership(campaigns: [], default_campaign: Membership_DefaultCampaign(commission: "", default_code_uuid: "", offer: "", uuid: ""), shop: Membership_Shop(customer_id: "", domain: "", icon: "", name: "", website: ""), status: "", timestamp: Membership_Timestamp(created: -1, disabled: -1), uuid: Membership_UUID(membership: "", shop: "", user: ""))
    var imageSource: String = "NONE"
    var title: String
    var subtitle: String = "Give 15%, get $10"
    var referralObject: String = "Need to add an object later to pass to the popup screen"
    var isLast: Bool
    
    @Binding var sheetContext: [String]
    @Binding var presentedSheet: PresentedSheet?
    
    @State var backgroundURL:String = ""

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                
                if backgroundURL != "" {
                    WebImage(url: URL(string: backgroundURL)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .padding(.trailing)
                } else {
                    
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                        .padding(.trailing)
//                    Image(systemName: "bag.fill")
//                        .font(.system(size: 48, weight: .regular))
//                        .foregroundColor(Color(.lightGray))
//                        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
//                        .padding(.vertical, 20)
                }
//                RoundedRectangle(cornerRadius: 6)
//                    .frame(width: 60, height: 60)
//                    .foregroundColor(.gray)
//                    .padding(.trailing)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.bottom, 4)
                    Text(subtitle)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.gray"))
                }
                
                Spacer()
                
                Button {
                    sheetContext[0] = "YES TAPPED BUTTON"
                    presentedSheet = .send
                    print("tapped")
                } label: {
                    
                    Text("Send")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("text.black"))
                        .padding(.vertical, 6)
                        .padding(.horizontal)
                        .background(Capsule().foregroundColor(Color("ShareGray")))
                }
                
                //            Image(systemName: "chevron.right")
                //                .font(.system(size: 15))
                //                .foregroundColor(Color("text.gray"))
                //                .padding(.leading)
                
            }
            .padding(.vertical, 10)
                
            if !isLast {
                
                Divider().padding(.leading, 60).padding(.leading)
                
            }
        }
        .onAppear {
            
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
}

