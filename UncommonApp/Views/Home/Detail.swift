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
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
                
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                
                //MARK: Title Section
                HStack(alignment: .bottom, spacing: 0) {
                 
                    VStack(alignment: .leading, spacing: 0) {
                        
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                            .padding(.bottom)
                        
                        Text(membership.company_name)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            
                    }
                        
                    Spacer()
                    
                }.padding().padding(.vertical)
                
                
                
                //MARK: My Discount Code Box
                VStack(alignment: .leading, spacing: 0) {
                    
                    //Title: My Referrals
                    HStack(alignment: .bottom, spacing: 0) {
                     
                        Text("My Referral Code")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            .padding(.bottom, 2)
                            
                        Spacer()
                        
                        Button {
                            //insert button action here..
                        } label: {
    
                            Text("Details")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("text.black"))
                                .padding(.vertical, 4)
                                .padding(.horizontal)
                                .background(Capsule().foregroundColor(Color("Background")))
                        }
                        
                    }.padding(.vertical, 10)
                    
                    //Subtitle: What the offer is
                    HStack(alignment: .bottom, spacing: 0) {
                        
                        Text("Give $10 to a friend, get $10 in cash")
                            .font(.system(size: 17, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                        Spacer()
                    }.padding(.bottom, 10).padding(.bottom)
                    
                    //My Code
                    HStack(alignment: .center, spacing: 0) {
                     
                        Text("COLIN123")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .kerning(1.2)
                            .foregroundColor(Color("text.black"))
                            
                        Spacer()
                        
                        Button {
                            //trigger the customize screen here...
                        } label: {
                            
                            Image(systemName: "square.on.square")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(Color("UncommonRed"))
                        }
                        
                        Button {
                            //trigger the customize screen here...
                        } label: {
                            Image(systemName: "link")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(Color("UncommonRed"))
                        }
                        
                        
                    }.padding(.horizontal).padding(.vertical, 15)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("TextFieldGray")))
                        .padding(.vertical).padding(.bottom)
                    
                    //Share button
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Share")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(Capsule().foregroundColor(Color("UncommonRed")))
                    
                }.padding().padding(.bottom, 10).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.bottom)
                    
                //MARK: My Stats Box
                VStack(alignment: .leading, spacing: 0) {
                    
                    //Title: My Stats
                    HStack(alignment: .bottom, spacing: 0) {
                     
                        Text("My Stats")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            .padding(.bottom, 2)
                            
                        Spacer()
                        
                    }.padding(.vertical, 10).padding(.bottom)
                    
                    //Line 1: My lifetime referrals
                    HStack(alignment: .center, spacing: 0) {
                     
                        Text("My lifetime referrals")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                            
                        Spacer()
                        
                        Text("15")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("text.black"))
                        
                    }.padding(.bottom)
                    
                    //Line 2: My lifetime earnings
                    HStack(alignment: .center, spacing: 0) {
                     
                        Text("My lifetime earnings")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                            
                        Spacer()
                        
                        Text("$150")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("text.black"))
                        
                    }.padding(.bottom)
                    
                    //Line 3: Something else
                    HStack(alignment: .center, spacing: 0) {
                     
                        Text("Something else")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(Color("text.gray"))
                            
                        Spacer()
                        
                        Text("Blah")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("text.black"))
                        
                    }.padding(.bottom).padding(.bottom, 10)
                    
                    //"See more" button
                    HStack(alignment: .center) {
                        Spacer()
                        Text("See more")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("UncommonRed"))
                        Spacer()
                    }
                    .frame(height: 50)
                    //.background(Capsule().foregroundColor(Color("UncommonRed")))
                    
                }.padding().padding(.bottom, 10).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.bottom)
                
                
                //MARK: Activity Box
                VStack(alignment: .leading, spacing: 0) {
                    
                    //Title: Activity
                    HStack(alignment: .bottom, spacing: 0) {
                     
                        Text("Activity")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            .padding(.bottom, 2)
                            
                        Spacer()
                        
                    }.padding(.vertical, 10).padding(.bottom)
                    
                    ActivityRow()
                    
//                    //ForEach item in historical activity
//                    ForEach(ordersVM.var_getAllOrders) { order in
//
//                        ActivityRow()
//                        ActivityRow()
//                        ActivityRow()
////                        NavigationLink(value: order) {
////
////                            Text(order.doc_id)
////
////                            ActivityRow()
////                            ActivityRow()
////                            ActivityRow()
////
////                        }
//                    }
                    
                    //"See more" button
                    HStack(alignment: .center) {
                        Spacer()
                        Text("See more")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color("UncommonRed"))
                        Spacer()
                    }
                    .frame(height: 50)
                    .padding(.top, 10)
                    //.background(Capsule().foregroundColor(Color("UncommonRed")))
                    
                }.padding().padding(.bottom, 10).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.bottom)
                
                Spacer()
                
            }.padding(.horizontal)
                .scrollIndicators(.hidden)
            .navigationTitle("")
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
            
        .onAppear {
            
                self.ordersVM.getAllOrders()

        }
    }
}


struct ActivityRow: View {
    
//    var membership: Memberships = Memberships(company_name: "", doc_id: "", ids: Memberships_Ids(campaigns: [""], company: "", domain: "", shopify_customer: "", user: ""), primary_campaign: Memberships_PrimaryCampaign(commission: Memberships_PrimaryCampaign_Commission(category: "", type: "", value: ""), linked_code: "", offer: Memberships_PrimaryCampaign_Offer(category: "", type: "", value: ""), primary_campaign_id: "", type: ""), stats: Memberships_Stats(total_cash: 0, total_discounts: 0, total_orders: 0, total_referrals: 0, total_sales: 0), status: "", timestamps: Memberships_Timestamps(joined: 0))
//    var imageSource: String = "NONE"
//    var title: String
//    var subtitle: String = "Give 15%, get $10"
//    var referralObject: String = "Need to add an object later to pass to the popup screen"
//    var isLast: Bool
    
    //@Binding var sheetContext: [String]
    //@Binding var presentedSheet: PresentedSheet?
    
    //@State var backgroundURL:String = ""

    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
                .padding(.trailing)
            
            VStack(alignment: .leading, spacing: 0) {
                
                //top line of text.. Date // Amount
                HStack(alignment: .center, spacing: 0) {
                    
                    Text("Dec 17")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("text.black"))
                    
                    Spacer()
                    
                    Text("$150")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("text.black"))
                    
                }.padding(.bottom, 4)
                
                //bottom line of text.. Details & Source
                HStack(alignment: .center, spacing: 0) {
                    
                    Text("Referral Used")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(Color("text.gray"))
                    
                    Spacer()
                    
                }
            }.padding(.vertical, 2)
        }
        .padding(.vertical, 10)
    }
}






//
////Subtitle: My Offer
//HStack(alignment: .top, spacing: 20) {
//
//    VStack(alignment: .leading, spacing: 0) {
//
//        Text("$19.00")
//            .font(.system(size: 34, weight: .bold, design: .rounded))
//            .foregroundColor(Color("text.black"))
//            .padding(.bottom, 4)
//
//        Text("For my friend")
//            .font(.system(size: 15, weight: .regular, design: .rounded))
//            .foregroundColor(Color("text.gray"))
//
//    }
//
//    Spacer()
//
//    VStack(alignment: .leading, spacing: 0) {
//
//        Text("3")
//            .font(.system(size: 34, weight: .bold, design: .rounded))
//            .foregroundColor(Color("text.black"))
//            .padding(.bottom, 4)
//
//        Text("For me")
//            .font(.system(size: 15, weight: .regular, design: .rounded))
//            .foregroundColor(Color("text.gray"))
//
//    }
//
//    Spacer()
//
//}
