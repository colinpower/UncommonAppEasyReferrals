////
////  CashOut.swift
////  UncommonApp
////
////  Created by Colin Power on 12/23/22.
////
//
//import SwiftUI
//import FirebaseFunctions                                                                 // NOTE: THE CALLABLE FUNCTION IS SET UP HERE
//import SDWebImageSwiftUI
//
//struct CashOut: View {
//
//    /// Receives the listeners for Users and Stripe Accounts from ContentView.
//    @ObservedObject var users_vm: UsersVM
//    @ObservedObject var stripe_accounts_vm: Stripe_AccountsVM
//
//    /// Initializes the new listeners for Memberships and Shops for the session.
//    @StateObject var cash_vm = CashVM()
//
//    /// Initializes the new listeners for Memberships and Shops for the session.
//    @State var cashoutpath = NavigationPath()
//    var stripesetup: [SetupPage] = [.init(screen: "StripeSetup", content: "")]
//
//    /// Initializes variables needed for this page
//
//    @State var textFromFunction = ""                                                      // NOTE: THE CALLABLE FUNCTION IS SET UP HERE
//
//    var body: some View {
//
//        NavigationStack(path: $cashoutpath) {
//
//            ZStack {
//                Color("Background").ignoresSafeArea()
//
//                VStack {
//
//                    //MARK: Title + Subtitle
//                    Text("Transfer to Bank")
//                        .font(.system(size: 34, weight: .bold, design: .rounded))
//                        .padding(.vertical).padding(.top).padding(.top)
//                        .foregroundColor(Color("text.black"))
//
//
//                    Text("Transfer your balance to your bank using Stripe, our payments partner.")
//                        .font(.system(size: 18, weight: .regular))
//                        .foregroundColor(Color("text.black"))
//                        .multilineTextAlignment(.center)
//                        .padding(.bottom)
//                        .padding(.bottom)
//                        .padding(.bottom)
//
//                    HStack {
//                        Spacer()
//                        Text(String(stripe_accounts_vm.one_stripe_account.account.balance))
//                            .font(.system(size: 60, weight: .bold, design: .rounded))
//                            .foregroundColor(Color.green)
//                            .padding(.bottom)
//                        Spacer()
//                    }
//
//                    Spacer()
//
//                    ///One of three scenarios: 1) not set up yet (setup.link = "")    OR 2) data missing (
//                    ///
//                    ///
//
//
//
//                    Button {
//
//                        lazy var functions = Functions.functions()
//
//                        let data123 = ["text": "RANDOM"]
//
//                        functions.httpsCallable("callable_fx").call(data123) { result, error in                   // NOTE: THE CALLABLE FUNCTION IS USED HERE
//                              // [START function_error]
//                              if let error = error as NSError? {
//                                if error.domain == FunctionsErrorDomain {
//                                  let code = FunctionsErrorCode(rawValue: error.code)
//                                  let message = error.localizedDescription
//                                  let details = error.userInfo[FunctionsErrorDetailsKey]
//                                }
//                                // [START_EXCLUDE]
//                                print(error)
//                                return
//                                  // [END_EXCLUDE]
//                              }
//                              // [END function_error]
//                              if let operationResult = (result?.data as? [String: Any]), let text = operationResult["text"] as? String {
//                                  self.textFromFunction = text
//                              }
//                            }
//
//                    } label: {
//                        HStack {
//                            Text("salk")
//                            Text(textFromFunction)
//                        }
//                    }
//
//                    if stripe_accounts_vm.one_stripe_account.setup.link == "" {
//
//                        Button {
//
//                            stripe_accounts_vm.createAccount(user_id: users_vm.one_user.uuid.user)
//
//                            cashoutpath.append(stripesetup[0])
//
//                        } label: {
//                            HStack(alignment: .center) {
//                                Spacer()
//                                Text("Create your account")
//                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
//                                    .foregroundColor(Color.black)
//                                Spacer()
//                            }
//                        }
//
//                    } else if stripe_accounts_vm.one_stripe_account.setup.charges_enabled == false {
//
//                        VStack {
//                            Text("More details required")
//                            Link(destination: URL(string: stripe_accounts_vm.one_stripe_account.setup.link)!) {
//                                HStack(alignment: .center) {
//                                    Spacer()
//                                    Text("Go to stripe")
//                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
//                                        .foregroundColor(Color.white)
//                                    Spacer()
//                                }
//                                .frame(height: 34)
//                                .background(Capsule().foregroundColor(Color.cyan))
//                            }
//                        }
//                    } else {
//
//                        HStack {
//                            Text("View Account")
//                            Spacer()
//                            Text("Cash out")
//                        }
//
//                    }
//
//
//
//                    Spacer()
//
//
//                    //MARK: Buttons on bottom
//
//                    HStack(alignment: .center) {
//                        Spacer()
//                        Text("Transfer $80")
//                            .font(.system(size: 18, weight: .semibold, design: .rounded))
//                            .foregroundColor(Color.white)
//                        Spacer()
//                        Text(cash_vm.my_cash.first?._PURPOSE ?? "NONE")
//                    }
//                    .frame(height: 50)
//                    //.background(Capsule().foregroundColor(Color("text.black")))
//                    .background(Capsule().foregroundColor(Color.green))
//                    //.background(Capsule().foregroundColor(Color("UncommonRed")))
//                    .padding(.horizontal)
//                    //.padding(.bottom, UIScreen.main.bounds.height * 0.1)
//
//                    HStack(alignment: .center) {
//                        Spacer()
//                        Text("View account on Stripe")
//                            .font(.system(size: 18, weight: .semibold, design: .rounded))
//                        //.foregroundColor(Color("UncommonRed"))
//                            .foregroundColor(Color.gray)
//                        Spacer()
//                    }
//                    .frame(height: 50)
//                    //.background(Capsule().foregroundColor(Color("UncommonRed")))
//                    .padding(.horizontal)
//                    //.padding(.bottom)
//
//
//                }
//                .padding()
//            }
//            .navigationDestination(for: SetupPage.self, destination: { page in
//                CreateStripeAccount(stripe_accounts_vm: stripe_accounts_vm)
//            })
//            .onAppear {
//
//                self.cash_vm.getMyCashRewards(userid: users_vm.one_user.uuid.user)
//
//                if (stripe_accounts_vm.one_stripe_account.account.acct_id != "") {
//                    stripe_accounts_vm.checkAccount(user_id: users_vm.one_user.uuid.user, acct_id: stripe_accounts_vm.one_stripe_account.account.acct_id)
//                }
//
//            }
//        }
//    }
//}
