//
//  CashOut.swift
//  UncommonApp
//
//  Created by Colin Power on 12/23/22.
//

import SwiftUI
import FirebaseFunctions
import FirebaseStorage
import SDWebImageSwiftUI

struct CashOut: View {
        
    /// Receives the listeners for Users and Stripe Accounts from ContentView.
    @ObservedObject var users_vm: UsersVM
    @ObservedObject var stripe_accounts_vm: Stripe_AccountsVM
    
    /// Initializes the new listeners for Memberships and Shops for the session.
    @StateObject var cash_vm = CashVM()
    @StateObject var referrals_vm = ReferralsVM()
    
    /// Initializes the new listeners for Memberships and Shops for the session.
    @State var cashoutpath = NavigationPath()
    var stripesetup: [SetupPage] = [.init(screen: "StripeSetup", content: "")]
    @State var presentedCashOutSheet: PresentedCashOutSheet? = nil
    
    /// Initializes variables needed for this page
    
    @State var textFromFunction = ""
    
    var body: some View {
        
        NavigationStack(path: $cashoutpath) {
            
            ZStack {
                Color("Background").ignoresSafeArea()
                ScrollView {
                    VStack {
                        
                        //MARK: Title + Subtitle
                        Text("Cash Earned")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .padding(.vertical).padding(.top).padding(.top)
                            .foregroundColor(Color("text.black"))
                            .padding(.bottom)
                            .padding(.bottom)
                        
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                Text("$" + String(stripe_accounts_vm.one_stripe_account.account.balance))
                                    .font(.system(size: 80, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.green)
                                Text(getAmountPending(object_array: referrals_vm.my_pending_referrals))
                                    .font(.system(size: 20, weight: .medium, design: .rounded))
                                    .foregroundColor(Color("text.gray"))
                            }
                            Spacer()
                        }
                        .padding(.bottom)
                        .padding(.bottom)
                        
                        Spacer()
                        
                        ///One of three scenarios:
                        ///     1) not set up yet (setup.link = "")
                        ///     2) data missing
                        ///     3) good to go
                        
                        if (stripe_accounts_vm.one_stripe_account.account.link.url == "") {         //MUST SET UP ACCOUNT STILL
                            
                            Button {
                                
                                stripe_accounts_vm.createAccount(user_id: users_vm.one_user.uuid.user)
                                
                                cashoutpath.append(stripesetup[0])
                                
                            } label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Text("Create your account")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(Color.black)
                                    Spacer()
                                }
                            }
                            
                        } else if stripe_accounts_vm.one_stripe_account.setup.charges_enabled == false {
                            
                            VStack {
                                Text("More details required")
                                Link(destination: URL(string: stripe_accounts_vm.one_stripe_account.setup.link)!) {
                                    HStack(alignment: .center) {
                                        Spacer()
                                        Text("Go to stripe")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                            .foregroundColor(Color.white)
                                        Spacer()
                                    }
                                    .frame(height: 34)
                                    .background(Capsule().foregroundColor(Color.cyan))
                                }
                            }
                            
                        } else {
                            
                            let tempURL = stripe_accounts_vm.one_stripe_account.account.link.url
                            
                            HStack {
                                Link(destination: URL(string: tempURL)!) {
                                    HStack(alignment: .center) {
                                        Spacer()
                                        Text("View Account")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                            .foregroundColor(Color.white)
                                        Spacer()
                                    }
                                    .frame(height: 50)
                                    .background(Capsule().foregroundColor(Color.cyan))
                                }.padding(.trailing)
                                
                                Button {
                                    presentedCashOutSheet = .cash_out
                                } label: {
                                    HStack(alignment: .center) {
                                        Spacer()
                                        Text("Cash Out")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                            .foregroundColor(Color.white)
                                        Spacer()
                                    }
                                    .frame(height: 50)
                                    .background(Capsule().foregroundColor(Color.green))
                                }
                                
                                
                            }
                            
                        }
                        
                        
                        
                        
                        VStack (alignment: .leading) {
                            
                            Text("History")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .padding(.vertical).padding(.top).padding(.top)
                                .foregroundColor(Color("text.black"))
                            
                            let array1:[HistoryObject] = cash_vm.my_cash.map { HistoryObject(shop_name: $0.shop.name, shop_uuid: $0.uuid.shop, timestamp: $0.timestamp.created, amount: $0.value, type: $0._PURPOSE)}
                            
                            let array2:[HistoryObject] = referrals_vm.my_pending_referrals.map { HistoryObject(shop_name: $0.shop.name, shop_uuid: $0.uuid.shop, timestamp: ($0.timestamp.created + $0.commission.duration_pending), amount: $0.commission.value, type: "PENDING")}
                            
                            let testArray:[HistoryObject] = array1 + array2
                            
                            let sortedArray:[HistoryObject] = testArray.sorted(by: { $0.timestamp > $1.timestamp })
                            
                            ForEach(sortedArray) { item in
                                
                                HistoryRow(data: item)
                                
                            }
                        }
                        
                        
                    }
                }
                .padding()
            }
            .navigationDestination(for: SetupPage.self, destination: { page in
                CreateStripeAccount(stripe_accounts_vm: stripe_accounts_vm)
            })
            .sheet(item: $presentedCashOutSheet, onDismiss: { presentedCashOutSheet = nil }) { sheet in

                switch sheet {        //profile, cash_out, setup_bank, mydiscounts, add, suggest
                    
                case .cash_out:
                    ConfirmCashOut(stripe_accounts_vm: stripe_accounts_vm, presentedCashOutSheet: $presentedCashOutSheet)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
            }
            .onAppear {
                
                self.cash_vm.getMyCashRewards(userid: users_vm.one_user.uuid.user)
                
                self.referrals_vm.getMyPendingReferrals()
                
                if (stripe_accounts_vm.one_stripe_account.account.acct_id != "") {
                    stripe_accounts_vm.checkAccount(user_id: users_vm.one_user.uuid.user, acct_id: stripe_accounts_vm.one_stripe_account.account.acct_id)
                }
                
            }
        }
    }
}




struct HistoryRow: View {

    var data: HistoryObject
    
    @State var backgroundURL:String = ""
    
    var body: some View {

        HStack(alignment: .center, spacing: 0) {

            /// Three scenarios: 1) Pending/Transfer + image fails, 2) Pending/Transfer + image succeeds, 3) Cash_Out
            
            if data.type == "PAYOUT" {
                Image(systemName: "dollarsign.square.fill")
                    .font(.system(size: 40, weight: .regular, design: .rounded))
                    .foregroundColor(Color("text.black"))
                    .frame(width: 40, height: 40)
                    .padding(.trailing)
            } else {
                if backgroundURL != "" {
                    WebImage(url: URL(string: backgroundURL)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.trailing)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }

            VStack(alignment: .leading, spacing: 0) {

                //top line of text.. Date // Amount
                HStack(alignment: .center, spacing: 0) {

                    Text(createTitle(shop_name: data.shop_name, type: data.type))
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("text.black"))

                    Spacer()

                    Text("$" + data.amount)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("text.black"))

                }.padding(.bottom, 4)

                //bottom line of text.. Details & Source
                HStack(alignment: .center, spacing: 0) {

                    Text(createSubtitle(timestamp: data.timestamp, type: data.type))
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.gray"))

                    Spacer()

                }
            }.padding(.vertical, 2)
        }
        .padding(.vertical, 10)
        .onAppear {
            
            if data.type != "PAYOUT" {
                let backgroundPath = "shops/" + data.shop_uuid + "/icon.png"
                
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
}


struct HistoryObject: Identifiable {
    
    var id = UUID().uuidString
    
    var shop_name: String
    var shop_uuid: String
    var timestamp: Int
    var amount: String
    var type: String
}



private func createTitle(shop_name: String, type: String) -> String {
    
    if type == "TRANSFER" {
        return (shop_name + "Referral")
    } else if type == "PAYOUT" {
        return "Cashed Out"
    } else if type == "PENDING" {
        return "Referral Pending"
    }
    else {
        return "ERROR"
    }

}

private func createSubtitle(timestamp: Int, type: String) -> String {
    
    if type == "PENDING" {
        return "Available on " + convertTimestampToShortDate(timestamp: timestamp)
    }
    else {
        return convertTimestampToShortDate(timestamp: timestamp)
    }
    
}

private func getAmountPending(object_array: [Referrals]) -> String {
    
    let pending_array:[Int] = object_array.map { Int(Double(($0.commission.value)) ?? 0) ?? 0 }
    
    let sum = pending_array.reduce(0, +)
    
    return "$" + String(sum) + " Pending"
    
}

//https://stackoverflow.com/questions/24795130/finding-sum-of-elements-in-swift-array


enum PresentedCashOutSheet: String, Identifiable {
    case cash_out
    var id: String {
        return self.rawValue
    }
}
