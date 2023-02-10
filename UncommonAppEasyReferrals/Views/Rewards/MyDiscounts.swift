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
    var discount: Codes
    var referral: Referrals
}


struct MyDiscounts: View {

    @ObservedObject var users_vm: UsersVM
    @ObservedObject var codes_vm: CodesVM
    @ObservedObject var referrals_vm: ReferralsVM

    @State var activeSheetForMyDiscounts: ActiveSheetForMyDiscounts? = nil

    @State var selectedDiscountObject:GridObject = GridObject(type: "", discount: EmptyVariables().empty_code, referral: EmptyVariables().empty_referral)


    var emptyDiscount = EmptyVariables().empty_code
    var emptyReferral = EmptyVariables().empty_referral

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
                    let array1:[GridObject] = codes_vm.my_active_discount_codes.map { GridObject(type: "AVAILABLE", discount: $0.self, referral: emptyReferral)}

                    let array2:[GridObject] = referrals_vm.my_pending_referrals.map { GridObject(type: "PENDING", discount: emptyDiscount, referral: $0.self)}

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

            self.codes_vm.listenForMyActiveDiscountCodes(user_id: users_vm.one_user.uuid.user)

        }
        .sheet(item: $activeSheetForMyDiscounts, onDismiss: { activeSheetForMyDiscounts = nil }) { [selectedDiscountObject] sheet in

            switch sheet {
            case .available:
//                AvailableDiscount(activeSheetForMyDiscounts: $activeSheetForMyDiscounts, code_vm: code_vm, discount: selectedDiscountObject.discount)
                LoadImageFromURL()

            case .pending:
//                PendingDiscount(activeSheetForMyDiscounts: $activeSheetForMyDiscounts, pendingReferral: selectedDiscountObject.referral)
                LoadImageFromURL()

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
