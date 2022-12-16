//
//  Detail.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import SwiftUI

struct Detail: View {
    
    var membership: Memberships
    
    @ObservedObject var ordersVM = OrdersVM()
    
    //var listItems = [1, 2, 3, 4]
    
    //@State var bool123 = false
    
    //@State var sheetContext = ["NONE", "fdasdf"]
    
    //@State private var presentedSheet: PresentedSheet? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
                
            Color("Background").ignoresSafeArea()
            
            ScrollView {
            //VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack(alignment: .bottom, spacing: 0) {
                     
                        VStack(alignment: .leading, spacing: 0) {
                            
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                            
                            Text(membership.company_name)
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                
                        }
                            
                        Spacer()
                        
                    }
                        .padding(.vertical, 10)
                    
                }.padding()
                    .padding(.bottom, 10)
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                    .padding(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    //Title: My Referrals
                    HStack(alignment: .bottom, spacing: 0) {
                     
                        Text("My Referrals")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            .padding(.bottom, 2)
                            
                        Spacer()
                        
                        Button {
    
                            
                        } label: {
    
                            Text("Details")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.vertical, 4)
                                .padding(.horizontal)
                                .background(Capsule().foregroundColor(Color("ShareGray")))
                        }
                        
                    }.padding(.vertical, 10)
                        .padding(.bottom)
                    
                    //Subtitle: My Offer
                    HStack(alignment: .top, spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            
                            Text("$19.00")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.bottom, 4)
                            
                            Text("For my friend")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundColor(Color("text.gray"))
                            
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            
                            Text("3")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.bottom, 4)
                            
                            Text("For me")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundColor(Color("text.gray"))
                            
                        }
                        
                        Spacer()
                            
                    }
                    
                    Divider().padding(.vertical)
                    
                    //Title 2: My Code
                    HStack(alignment: .bottom, spacing: 0) {
                     
                        Text("My Referral Code")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            .padding(.bottom, 2)
                            
                        Spacer()
                        
                    }.padding(.vertical, 10)
                        .padding(.bottom)
                    
                    //Tappable code
                    Button {
                        
                    } label: {
                        
                        HStack(alignment: .center, spacing: 0) {
                            Text(membership.primary_campaign.linked_code)
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                            Spacer()
                            Text("x")
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                        .background(Rectangle().foregroundColor(Color("ShareGray")))
                    }
                    
                    
                }.padding()
                    .padding(.bottom, 10)
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("asldfkjalsdkfj")
//                    ForEach(ordersVM.var_getAllOrders) { order in
//
//                        NavigationLink(value: order) {
//
//                            Text(order.doc_id)
//                            //programRow(membership: membership, title: membership.company_name, isLast: membership == membershipsVM.var_getMyMemberships.last, sheetContext: $sheetContext, presentedSheet: $presentedSheet)
//                            //programRow(title: membership.company_name, isLast: referralprogram == referralProgramVM.referralPrograms.last, sheetContext: $sheetContext, presentedSheet: $presentedSheet)
//                        }
//                    }
                    
                }.padding(.bottom, 10)
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                    .padding(.horizontal)
                    
                
                Spacer()
                
            }
            .navigationTitle(membership.company_name)
            .navigationDestination(for: Orders.self) { order in
                VStack {
                    Text("order")
                    Text(order.ids.company)
                }
//                    Label(membership.company_name, systemImage: "circle.fill")
//                        .font(.headline)
            }
        }
            
        .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                    }
                }
                
            }
            
            
//            .sheet(item: $presentedSheet, onDismiss: { presentedSheet = nil }) { [sheetContext] sheet in
//
//                switch sheet {
//                case .share:
//                    Share(sheetContext: $sheetContext)
//                        .presentationDetents([.medium])
//                        .presentationDragIndicator(.visible)
//                case .sharepersonalized:
//                    SharePersonalized(sheetContext: $sheetContext)
//                        .presentationDetents([.medium])
//                        .presentationDragIndicator(.visible)
//                case .myrewards:
//                    MyRewards(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
//                        .presentationDetents([.large])
//                        .presentationDragIndicator(.visible)
//                case .profile:
//                    Profile()
//                        .presentationDetents([.large])
//                        .presentationDragIndicator(.visible)
//                default:
//                    MyRewards(sheetContext: $sheetContext, presentedSheet: $presentedSheet)
//                        .presentationDetents([.large])
//                    //ReviewProductCarousel1(activeReviewOrReferSheet: $activeReviewOrReferSheet, item: item)
//                }
//            }
            .onAppear {
                
//                    self.referralProgramVM.getReferralPrograms()
//                    self.campaignsVM.getOneCampaign()
//                    self.codesVM.getOneCode(codeId: "Fr2FcjT5gkCcq01fSGlc")
//                    self.companiesVM.getAllCompanies()
//                self.membershipsVM.getMyMemberships(userId: "2qLkpCLAOpAKZauBkney")
                    self.ordersVM.getAllOrders()
//                    self.referralsVM.getReferrals()
//                    self.rewardsVM.getRewards()
//                    self.usersVM.getAllUsers()
        }
    }
}

//struct Detail_Previews: PreviewProvider {
//    static var previews: some View {
//        Detail()
//    }
//}
