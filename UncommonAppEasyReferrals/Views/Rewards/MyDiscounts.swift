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

struct GridObject: Identifiable {
    
    var id = UUID().uuidString
    var type: String
    var discount: DiscountReward
    var referral: Referral
}


struct MyDiscounts: View {
    
    @ObservedObject var code_vm: CodeVM
    
    var myActiveDiscounts: [DiscountReward]
    var myPendingDiscounts: [Referral]
    
    @State var activeSheetForMyDiscounts: ActiveSheetForMyDiscounts? = nil
    
    @State var selectedDiscountObject:GridObject = GridObject(type: "",
                                                                      discount: DiscountReward(code: DiscountReward_Code(code: "", duration: -1, graphql_id: "", minimum_spend: -1, starts_at: -1, type: "", usage_limit: -1, value: ""), shop: DiscountReward_Shop(domain: "", icon: "", name: "", website: ""), status: "EMPTY", timestamp: DiscountReward_Timestamp(created: -1, deleted: -1, expired: -1, returned: -1, used: -1), uuid: DiscountReward_UUID(campaign: "", code: "", discount_reward: "", membership: "", order: "", referral: "", shop: "", user: "")),
                                                                      referral: Referral(commission: Referral_Commission(duration_pending: -1, offer: "", type: "", value: ""), offer: "", revenue: "", shop: Referral_Shop(domain: "", icon: "", name: "", website: ""), status: "EMPTY", timestamp: Referral_Timestamp(completed: -1, created: -1, deleted: -1, flagged: -1, returned: -1), uuid: Referral_UUID(campaign: "", cash_reward: "", code: "", discount_reward: "", membership: "", order: "", referral: "", shop: "", user: ""))
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
                    
                    //MARK: Create the array joining the Discounts and the Pending Referrals together
                    let array1:[GridObject] = myActiveDiscounts.map { GridObject(type: "AVAILABLE", discount: $0.self, referral: emptyReferral)}
                    
                    let array2:[GridObject] = myPendingDiscounts.map { GridObject(type: "PENDING", discount: emptyDiscount, referral: $0.self)}
                    
                    let array3:[GridObject] = array1 + array2
                    
                    let array4:[GridObject] = array3.sorted(by: { $0.type < $1.type })
                    
                    //MARK: Boxes: LazyVGrid for Discounts
                    LazyVGrid(columns: columns, spacing: 16) {

                        ForEach(array4) { gridObject in

                            Button {
                                
                                selectedDiscountObject = gridObject
                                
                                if gridObject.type == "AVAILABLE" {
                                    activeSheetForMyDiscounts = .available
                                } else {
                                    activeSheetForMyDiscounts = .pending
                                }
                                
                            } label: {
                                LazyVGridWidget(gridObject: gridObject)
                            }
                        }

                    }
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            self.code_vm.one_code = Code(code: Code_Code(code: "", color: [], graphql_id: "", is_default: false), shop: Code_Shop(domain: "", name: "", website: ""), stats: Code_Stats(usage_count: -1, usage_limit: -1), status: Code_Status(did_creation_succeed: false, status: "EMPTY"), timestamp: Code_Timestamp(created: -1, deleted: -1, used: -1), uuid: Code_UUID(campaign: "", code: "", membership: "", shop: "", user: ""))
        }
        .sheet(item: $activeSheetForMyDiscounts, onDismiss: { activeSheetForMyDiscounts = nil }) { [selectedDiscountObject] sheet in
            
            switch sheet {
            case .available:
                AvailableDiscount(activeSheetForMyDiscounts: $activeSheetForMyDiscounts, code_vm: code_vm, discount: selectedDiscountObject.discount)
                
            case .pending:
                PendingDiscount(activeSheetForMyDiscounts: $activeSheetForMyDiscounts, pendingReferral: selectedDiscountObject.referral)
                
            }
            
        }
    }
}



struct LazyVGridWidget: View {

    var gridObject: GridObject
    
    
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
            Text(gridObject.type == "AVAILABLE" ? gridObject.discount.shop.name : gridObject.referral.shop.name)
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
            
            if gridObject.type == "AVAILABLE" {
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
            } else {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Pending")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .frame(height: 34)
                .background(Capsule().foregroundColor(Color.gray))
            }
            
            
        }.padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
    }
}
