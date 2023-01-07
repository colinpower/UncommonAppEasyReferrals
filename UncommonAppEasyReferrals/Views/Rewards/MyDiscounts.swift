//
//  MyRewards.swift
//  UncommonApp
//
//  Created by Colin Power on 12/5/22.
//

import SwiftUI

enum ActiveSheetForMyDiscounts: String, Identifiable { // <--- note that it's now Identifiable
    case available, pending
    var id: String {
        return self.rawValue
    }
}

struct DiscountObject: Identifiable {
    
    var id = UUID().uuidString
    var type: String
    var discountObject: DiscountReward
    var referralObject: Referral
}


struct MyDiscounts: View {
    
    var myActiveDiscounts: [DiscountReward]
    var myPendingDiscounts: [Referral]
    
    @State var activeSheetForMyDiscounts: ActiveSheetForMyDiscounts? = nil
    
    @State var selectedDiscountObject:DiscountObject = DiscountObject(type: "",
                                                                      discountObject: DiscountReward(code: DiscountReward_Code(code: "", duration: -1, graphql_id: "", minimum_spend: -1, starts_at: -1, type: "", usage_limit: -1, value: ""), shop: DiscountReward_Shop(domain: "", icon: "", name: "", website: ""), status: "EMPTY", timestamp: DiscountReward_Timestamp(created: -1, deleted: -1, expired: -1, returned: -1, used: -1), uuid: DiscountReward_UUID(campaign: "", code: "", discount_reward: "", membership: "", order: "", referral: "", shop: "", user: "")),
                                                                      referralObject: Referral(commission: Referral_Commission(duration_pending: -1, offer: "", type: "", value: ""), offer: "", revenue: "", shop: Referral_Shop(domain: "", icon: "", name: "", website: ""), status: "EMPTY", timestamp: Referral_Timestamp(completed: -1, created: -1, deleted: -1, flagged: -1, returned: -1), uuid: Referral_UUID(campaign: "", cash_reward: "", code: "", discount_reward: "", membership: "", order: "", referral: "", shop: "", user: ""))
    )
    
    
    var emptyDiscount = DiscountReward(code: DiscountReward_Code(code: "", duration: -1, graphql_id: "", minimum_spend: -1, starts_at: -1, type: "", usage_limit: -1, value: ""), shop: DiscountReward_Shop(domain: "", icon: "", name: "", website: ""), status: "EMPTY", timestamp: DiscountReward_Timestamp(created: -1, deleted: -1, expired: -1, returned: -1, used: -1), uuid: DiscountReward_UUID(campaign: "", code: "", discount_reward: "", membership: "", order: "", referral: "", shop: "", user: ""))
    var emptyReferral = Referral(commission: Referral_Commission(duration_pending: -1, offer: "", type: "", value: ""), offer: "", revenue: "", shop: Referral_Shop(domain: "", icon: "", name: "", website: ""), status: "EMPTY", timestamp: Referral_Timestamp(completed: -1, created: -1, deleted: -1, flagged: -1, returned: -1), uuid: Referral_UUID(campaign: "", cash_reward: "", code: "", discount_reward: "", membership: "", order: "", referral: "", shop: "", user: ""))
    
    let columns: [GridItem] = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2 - 32), spacing: 16, alignment: nil),
            GridItem(.fixed(UIScreen.main.bounds.width / 2 - 32), spacing: 16, alignment: nil)
        ]
    
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            Color.cyan.opacity(0.1).ignoresSafeArea()
            
            ScrollView {
                VStack {

                    
                    //MARK: Title + Subtitle
                    
                    Text("My Discounts")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .padding(.vertical).padding(.top).padding(.top)
                    Text("These are the discounts you've earned. Tap on a discount to use it")
                        .font(.system(size: 18, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                        .padding(.bottom)
                    
                    //MARK: Boxes: LazyVGrid for Discounts
                    LazyVGrid(columns: columns, spacing: 16) {
                                                    
                        ForEach(myActiveDiscounts) { activediscount in
                            
                            Button {
                                selectedDiscountObject.type = "AVAILABLE"
                                selectedDiscountObject.discountObject = activediscount
                                selectedDiscountObject.referralObject = emptyReferral
                                
                                //selectedDiscount = activediscount
                                activeSheetForMyDiscounts = .available
                            } label: {
                                LazyVGridWidget(discount: activediscount)
                            }
                        }
                        
                    }
                    
                    Divider().padding(.vertical).padding(.vertical)
                    
                    //MARK: Boxes: LazyVGrid for Pending discounts
                    LazyVGrid(columns: columns, spacing: 16) {
                                                    
                        ForEach(myPendingDiscounts) { pendingDiscount in
                            
                            Button {
                                
                                selectedDiscountObject.type = "PENDING"
                                selectedDiscountObject.discountObject = emptyDiscount
                                selectedDiscountObject.referralObject = pendingDiscount
                                
                                //selectedDiscount = activediscount
                                activeSheetForMyDiscounts = .pending
                                
                            } label: {
                                LazyVGridWidgetForPending(discount: pendingDiscount)
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .sheet(item: $activeSheetForMyDiscounts, onDismiss: { activeSheetForMyDiscounts = nil }) { [selectedDiscountObject] sheet in
            
            switch sheet {
            case .available:
                AvailableDiscount(activeSheetForMyDiscounts: $activeSheetForMyDiscounts, discount: selectedDiscountObject.discountObject)
                
            case .pending:
                PendingDiscount(activeSheetForMyDiscounts: $activeSheetForMyDiscounts, pendingReferral: selectedDiscountObject.referralObject)
                
            }
            
        }
    }
}



struct LazyVGridWidget: View {

    var discount: DiscountReward
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //Icon
            HStack(alignment: .center, spacing: 0) {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                Spacer()
            }.padding(.bottom, 8)
            
            //Company
            Text(discount.shop.name)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color("text.black"))
                .padding(.bottom)
            
            //Discount
            Text("Get $15 off any order")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(Color("text.black"))
                .frame(height: 50, alignment: .bottom)
                .multilineTextAlignment(.leading)
                .padding(.bottom)
            
            //Button
            let tempURL = "https://www.google.com" //"https://" + discount.shop.domain + "/discount/" + discount.code.code + "?redirect=/collections/all"
            
            Link(destination: URL(string: tempURL)!) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Spend")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .frame(height: 34)
                .background(Capsule().foregroundColor(Color.cyan))
            }
            
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
    }
}

struct LazyVGridWidgetForPending: View {

    var discount: Referral
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            //Icon
            HStack(alignment: .center, spacing: 0) {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                Spacer()
            }.padding(.bottom, 8)
            
            //Company
            Text(discount.shop.name)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color("text.black"))
                .padding(.bottom)
            
            //Discount
            Text("Get $15 off any order")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(Color("text.black"))
                .frame(height: 50, alignment: .bottom)
                .multilineTextAlignment(.leading)
                .padding(.bottom)
            
            //Button
            HStack(alignment: .center) {
                Spacer()
                Text("Pending")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.white)
                Spacer()
            }
            .frame(height: 34)
            .background(Capsule().foregroundColor(Color.gray))
            
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
    }
}
