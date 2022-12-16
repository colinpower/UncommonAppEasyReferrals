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
    case profile, myrewards, add, share, sharepersonalized
    var id: String {
        return self.rawValue
    }
}


//how to do NavigationPath
//https://www.youtube.com/watch?v=oxp8Qqwr4AY


struct Home: View {
        
    @ObservedObject var campaignsVM = CampaignsVM()
    @ObservedObject var codesVM = CodesVM()
    @ObservedObject var companiesVM = CompaniesVM()
    @ObservedObject var membershipsVM = MembershipsVM()
    @ObservedObject var ordersVM = OrdersVM()
    @ObservedObject var referralsVM = ReferralsVM()
    @ObservedObject var rewardsVM = RewardsVM()
    @ObservedObject var usersVM = UsersVM()
    
    
    
    var listItems = [1, 2, 3, 4]
    
    @State var bool123 = false
    
    @State var sheetContext = ["NONE", "fdasdf"]
    
    @State private var presentedSheet: PresentedSheet? = nil
    
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .top) {
                    
                Color("Background").ignoresSafeArea()
                
                ScrollView {
                //VStack(alignment: .leading, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack(alignment: .bottom, spacing: 0) {
                         
                            Text("My Rewards")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.bottom, 2)
                                
                            Spacer()
                            
                            Button {
                                presentedSheet = .myrewards
                            } label: {
                                Text("Use")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color("text.black"))
                                    .padding(.vertical, 4)
                                    .padding(.horizontal)
                                    .background(Capsule().foregroundColor(Color("ShareGray")))
                            }
                            
                            
                        }.padding(.vertical, 10)
                            .padding(.bottom)
                        
                        HStack(alignment: .top, spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text("$19.00")
                                    .font(.system(size: 34, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("text.black"))
                                    .padding(.bottom, 4)
                                
                                Text("Cash Balance")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundColor(Color("text.gray"))
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text("3")
                                    .font(.system(size: 34, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("text.black"))
                                    .padding(.bottom, 4)
                                
                                Text("Discounts")
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundColor(Color("text.gray"))
                                
                            }
                            
                            Spacer()
                                
                        }
                        
                    }.padding()
                        .padding(.bottom, 10)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                        .padding(.all)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
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
                                    .background(Capsule().foregroundColor(Color("ShareGray")))
                                
                            }
                            
                            
                        }.padding(.vertical, 10)
                            .padding(.bottom)
                        
                        ForEach(membershipsVM.var_getMyMemberships) { membership in
                            
                            NavigationLink(value: membership) {
                                programRow(membership: membership, title: membership.company_name, isLast: membership == membershipsVM.var_getMyMemberships.last, sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                                //programRow(title: membership.company_name, isLast: referralprogram == referralProgramVM.referralPrograms.last, sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            }
                        }
                        
                        
                    }.padding()
                        .padding(.bottom, 10)
                        .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                        .padding(.horizontal)
                        
                    
                    Spacer()
                    
                }
                .navigationTitle("")
                .navigationDestination(for: Memberships.self) { membership in
                    Detail(membership: membership)
//                    Label(membership.company_name, systemImage: "circle.fill")
//                        .font(.headline)
                }
                
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        HStack(alignment: .center, spacing: 0) {
                            
                            Image("icon.black")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.trailing, 8)
                                .padding(.top, 5)
                            
                            Text("Uncommon")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.top, 5)
                            
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
            
                    switch sheet {
                    case .share:
                        Share(sheetContext: $sheetContext)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                    case .sharepersonalized:
                        SharePersonalized(sheetContext: $sheetContext)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                    case .myrewards:
                        MyRewards(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    case .profile:
                        Profile()
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    default:
                        MyRewards(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
                            .presentationDetents([.large])
                        //ReviewProductCarousel1(activeReviewOrReferSheet: $activeReviewOrReferSheet, item: item)
                    }
                }
                .onAppear {
                    
//                    self.referralProgramVM.getReferralPrograms()
//                    self.campaignsVM.getOneCampaign()
//                    self.codesVM.getOneCode(codeId: "Fr2FcjT5gkCcq01fSGlc")
//                    self.companiesVM.getAllCompanies()
                    self.membershipsVM.getMyMemberships(userId: "2qLkpCLAOpAKZauBkney")
//                    self.ordersVM.getAllOrders()
//                    self.referralsVM.getReferrals()
//                    self.rewardsVM.getRewards()
//                    self.usersVM.getAllUsers()
                }
            }
        }
        
    }
    
    
}

struct programRow: View {
    
    var membership: Memberships = Memberships(company_name: "", doc_id: "", ids: Memberships_Ids(campaigns: [""], company: "", domain: "", shopify_customer: "", user: ""), primary_campaign: Memberships_PrimaryCampaign(commission: Memberships_PrimaryCampaign_Commission(category: "", type: "", value: ""), linked_code: "", offer: Memberships_PrimaryCampaign_Offer(category: "", type: "", value: ""), primary_campaign_id: "", type: ""), stats: Memberships_Stats(total_cash: 0, total_discounts: 0, total_orders: 0, total_referrals: 0, total_sales: 0), status: "", timestamps: Memberships_Timestamps(joined: 0))
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
                    presentedSheet = .sharepersonalized
                    print("tapped")
                } label: {
                    
                    Text("Send")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("text.black"))
                        .padding(.vertical, 6)
                        .padding(.horizontal)
                        .background(Capsule().foregroundColor(Color("text.gray").opacity(0.3)))
                    
                    //                    .foregroundColor(Color("text.gray"))
                    //                ZStack(alignment: .center) {
                    //
                    //                    Circle()
                    //                        .frame(width: 32, height: 32)
                    //                        .foregroundColor(Color("ShareGray"))
                    //                    Image(systemName: "paperplane.fill")
                    //                        .font(.system(size: 16))
                    //                        .foregroundColor(Color.blue)
                    //                }
                    
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
            
            let backgroundPath = "companies/" + membership.ids.company + "/logo.png"
            
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
