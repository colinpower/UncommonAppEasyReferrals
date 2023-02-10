//
//  ConfirmCashOut.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 2/10/23.
//

import SwiftUI
import FirebaseFunctions

struct ConfirmCashOut: View {
    
    @ObservedObject var stripe_accounts_vm: Stripe_AccountsVM
    @Binding var presentedCashOutSheet: PresentedCashOutSheet?
    
    @State private var confirmCashOutState: ConfirmCashOutState = .CHECKING_BALANCE
    
    var body: some View {
        VStack (alignment: .center) {
            //MARK: Title + Subtitle
            Text("Instant Transfer")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .padding(.vertical).padding(.top).padding(.top)
                .foregroundColor(Color("text.black"))
            
            Text("Transfer your earned cash to your bank. They will arrive in 30 minutes.")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Color.black)
                .padding(.bottom)
            
            // MARK: Balance
            if confirmCashOutState == .CHECKING_BALANCE {
                checkingBalance
            } else if confirmCashOutState == .ERROR_GETTING_BALANCE {
                errorGettingBalance
            } else {
                currentBalance
            }
            
            
            if confirmCashOutState == .RETRIEVED_BALANCE {
                transferButton
            } else if confirmCashOutState == .REQUESTING_TRANSFER {
                requestingTransferButton
            } else if confirmCashOutState == .TRANSFERRED {
                transferredButton
            } else {
                disabledButton
            }
            
            
        }
        .onAppear {
            
            retrieveCurrentBalance(acct_id: stripe_accounts_vm.one_stripe_account.account.acct_id)
            
        }
    }
    
    var checkingBalance: some View {
        
        VStack(alignment: .center) {
            ProgressView()
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(Color.green)
                .padding(.vertical)
                .padding(.vertical)
            Text("Checking Balance ...")
                .foregroundColor(Color.gray)
        }.frame(height: 100)
        
    }
    
    var errorGettingBalance: some View {
        
        VStack(alignment: .center) {
            Text("Error")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(Color.red)
                .padding(.vertical)
                .padding(.vertical)
            Text("Error retrieving balance.")
                .foregroundColor(Color.gray)
        }.frame(height: 100)
        
    }
    
    var currentBalance: some View {
        
        VStack(alignment: .center) {
            Text("$" + String(stripe_accounts_vm.one_stripe_account.account.balance))
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .foregroundColor(Color.green)
            
            Text("Your available balance")
                .foregroundColor(Color.gray)
        }.frame(height: 100)
        
    }
    
    var transferButton: some View {
        
        Button {
            
            print("button pressed")
            
            // 1) make request to transfer money
            
            // 2)
            
            self.confirmCashOutState = .REQUESTING_TRANSFER
            
            requestTransfer(acct_id: stripe_accounts_vm.one_stripe_account.account.acct_id, amountInCents: 100)
            
            
        } label: {
            
            // Possible scenarios:
            // 1) no money in balance, gray out button
            // 2) money available, not instant transfer though
            // 3) money available, instant cash available
            // 4) transfer started, but waiting on response
            // 5) successful transfer, delay 1s and then close the window
            

            
            HStack(alignment: .center) {
                Spacer()
                Text("Transfer")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.white)
                Spacer()
            }
            .frame(height: 50)
            .background(Capsule().foregroundColor(Color.green))
            
        }
        
        
    }
    
    var requestingTransferButton: some View {
        
        HStack(alignment: .center) {
            Spacer()
            ProgressView()
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Color.white)
            Spacer()
        }
        .frame(height: 50)
        .background(Capsule().foregroundColor(Color.green.opacity(0.5)))
    }
    
    var transferredButton: some View {
        
        HStack(alignment: .center) {
            Spacer()
            Text("Transferred")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Color.white)
            Spacer()
        }
        .frame(height: 50)
        .background(Capsule().foregroundColor(Color.green.opacity(0.5)))
    }
    
    var disabledButton: some View {
        
        HStack(alignment: .center) {
            Spacer()
            Text("Transfer")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Color.gray)
            Spacer()
        }
        .frame(height: 50)
        .background(Capsule().foregroundColor(Color.gray.opacity(0.5)))
    }
    

    private func retrieveCurrentBalance(acct_id: String) {
        
        lazy var functions = Functions.functions()
        
        let object = ["acct_id": acct_id]
        
        functions.httpsCallable("call_stripe_balance_fx").call(object) { result, error in                   // NOTE: THE CALLABLE FUNCTION IS USED HERE
            // [START function_error]
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
                // [START_EXCLUDE]
                print(error)
                self.confirmCashOutState = .ERROR_GETTING_BALANCE
                return
                // [END_EXCLUDE]
            }
            // [END function_error]
            if let operationResult = (result?.data as? [String: Any]), let text = operationResult["result"] as? String {
    
                self.confirmCashOutState = .RETRIEVED_BALANCE
                
            }
        }
    }
    
    private func requestTransfer(acct_id: String, amountInCents: Int) {
        
        lazy var functions = Functions.functions()
        
        let object = ["acct_id": acct_id, "amount_in_cents": amountInCents] as [String : Any]
        
        functions.httpsCallable("call_stripe_payout_fx").call(object) { result, error in                   // NOTE: THE CALLABLE FUNCTION IS USED HERE
            // [START function_error]
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
                // [START_EXCLUDE]
                print(error)
                self.confirmCashOutState = .ERROR_WITH_TRANSFER
                return
                // [END_EXCLUDE]
            }
            // [END function_error]
            if let operationResult = (result?.data as? [String: Any]), let response = operationResult["result"] as? String {
                
                if response == "SUCCESS" {
                    self.confirmCashOutState = .TRANSFERRED
                    
                    retrieveCurrentBalance(acct_id: acct_id)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        presentedCashOutSheet = nil
                        
                    }
                } else {
                    
                    self.confirmCashOutState = .ERROR_WITH_TRANSFER
                }
                
                
            }
        }
    }
    
}


struct TempBalanceObject {
    
    var state: String               // NOT STARTED, CHECKING, ERROR, SUCCESS
    var balance: Int                // must be converted on client
    var shop_uuid: String
    var timestamp: Int
    var amount: String
    var type: String
}


enum ConfirmCashOutState: String, Identifiable {            //NOT_STARTED, CHECKING_BALANCE, ERROR_GETTING_BALANCE, RETRIEVED_BALANCE, REQUESTING_TRANSFER, ERROR_WITH_TRANSFER, TRANSFERRED
    case NOT_STARTED, CHECKING_BALANCE, ERROR_GETTING_BALANCE, RETRIEVED_BALANCE, REQUESTING_TRANSFER, ERROR_WITH_TRANSFER, TRANSFERRED
    var id: String {
        return self.rawValue
    }
}


