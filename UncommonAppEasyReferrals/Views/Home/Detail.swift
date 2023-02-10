//
//  Detail.swift
//  UncommonApp
//
//  Created by Colin Power on 12/12/22.
//

import SwiftUI




struct Detail: View {

    @Environment(\.displayScale) var displayScale

    /// Receives the listener for Users from Home View.
    @ObservedObject var users_vm: UsersVM
    
    /// Receives the Membership from Home View.
    var membership: Memberships

    /// Creates the listeners for the user's default Code and the user's Orders (to list order history).
    @StateObject var codes_vm = CodesVM()
    //@StateObject var orders_vm = OrdersVM()                               // TODO: Need to add Orders Model and ViewModel
    
    /// Creates the observers to retrieve the campaign and the shop
    @StateObject private var campaigns_vm = CampaignsVM()
    
    /// Tracks whether "Copy" has been tapped.
    @State var isCopyTapped: Bool = false
    @State var isCopyLinkTapped: Bool = false

    /// Determines which sheet to present, and passes along a value (for now, it's ShopObject)
    @State private var presentedDetailSheet: PresentedDetailSheet? = nil
    @State private var selectedDetailObject:ShopObject = ShopObject(shop: EmptyVariables().empty_shop)

    /// Creates a blank Struct which will be used for sending the referral cards when the user hits "Share"
    @State var referralCardStruct = ReferralCardStruct(
        image: Image(systemName: "photo"),
        text: "No code added",
        link: "No link added")

    var body: some View {
        ZStack(alignment: .top) {

            Color("Background").ignoresSafeArea()

            ScrollView {

                ReferralCard(cardColor: .blue, textColor: .white, iconPath: membership.uuid.shop, name: membership.shop.name, offer: membership.default_campaign.offer.value, code: codes_vm.one_code.code.code, hasShadow: true)
                    .padding(.bottom, 10)

                //MARK: "Share" box
                HStack(alignment: .center, spacing: 0) {

                    VStack(alignment: .leading, spacing: 0) {
                        Text("You'll earn")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color("text.black"))
                        Text("$" + campaigns_vm.one_campaign.commission.value)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                    }

                    Spacer()

                    let codeURL = "https://" + codes_vm.one_code.shop.domain + "/discount/" + codes_vm.one_code.code.code + "?redirect=/collections/all"
                    let previewText = membership.default_campaign.offer.value + " at " + codes_vm.one_code.shop.name + " with " + codes_vm.one_code.code.code
                    let messageText = "Use " + codes_vm.one_code.code.code + " for " + membership.default_campaign.offer.value + " off, or shop with this link: " + codeURL
                    let updatedImage = renderInCode(code: codes_vm.one_code.code.code)

                    //let testVar:ReferralCardStruct = ReferralCardStruct(image: referralCardStruct.image, text: previewText, link: messageText)
                    let referralCardStruct = ReferralCardStruct(image: updatedImage, text: previewText, link: messageText)

                    ShareLink(item: referralCardStruct.image,
                              message: Text(referralCardStruct.link),
                              //preview: SharePreview(referralCardStruct.text, image: Image(systemName: "creditcard.fill"))) {
                              preview: SharePreview(referralCardStruct.text)) {

                        Text("Send \(campaigns_vm.one_campaign.offer.value)")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 17)
                            .background(Capsule().foregroundColor(Color("text.black")))
                    }

                }.padding()
                    .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
                    .padding(.horizontal)
                    .padding(.bottom)


                //MARK: My Referral Code Box
                VStack(alignment: .leading, spacing: 0) {

                    //Title: My Referrals
                    HStack(alignment: .bottom, spacing: 0) {

                        Spacer()

                        Text("My Referral Code")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(Color("text.black"))
                            .padding(.bottom, 2)

                        Spacer()

                    }.padding(.vertical, 10).padding(.bottom)

                    //My Code
                    HStack(alignment: .center, spacing: 0) {

                        if isCopyLinkTapped {
                            Text("Link copied")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .kerning(1.2)
                                .foregroundColor(Color("UncommonRed"))
                        } else if isCopyTapped {
                            Text("Code copied")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .kerning(1.2)
                                .foregroundColor(Color("UncommonRed"))
                        } else {
                            Text(codes_vm.one_code.code.code)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .kerning(1.2)
                                .foregroundColor(Color("text.black"))
                        }

                        Spacer()

                        Button {

                            isCopyTapped = true

                            UIPasteboard.general.string = codes_vm.one_code.code.code

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isCopyTapped = false
                            }

                        } label: {

                            Image(systemName: isCopyTapped ? "checkmark" : "square.on.square")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("UncommonRed"))
                                .frame(width: 24, height: 24)

                        }.padding(.trailing)

                        Button {

                            isCopyLinkTapped = true

                            let codeURL = "https://" + codes_vm.one_code.shop.domain + "/discount/" + codes_vm.one_code.code.code + "?redirect=/collections/all"

                            UIPasteboard.general.string = codeURL

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isCopyLinkTapped = false
                            }
                        } label: {

                            Image(systemName: isCopyLinkTapped ? "checkmark" : "link")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("UncommonRed"))
                                .frame(width: 24, height: 24)
                        }


                    }.padding(.horizontal).padding(.vertical, 18)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color("TextFieldGray")))
                        .padding(.vertical).padding(.bottom)

                    //Customize button
                    Button {
                        presentedDetailSheet = .customize
                    } label: {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Customize your code")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("UncommonRed"))
                            Spacer()
                        }
                        .frame(height: 50)
                    }

                }.padding().background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.bottom)
                    .padding(.horizontal)

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

                    StatsRow(title: "My Lifetime Referrals", value: "25")
                    StatsRow(title: "My Lifetime Earnings", value: "$150")
                    StatsRow(title: "Something Else", value: "25")
                        .padding(.bottom, 10)

                    //"See more" button
                    Button {
                        presentedDetailSheet = .stats
                    } label: {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("See more")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("UncommonRed"))
                            Spacer()
                        }
                        .frame(height: 50)
                    }
                }.padding().padding(.bottom, 10).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.bottom)


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
                    ActivityRow()
                    ActivityRow()

                    //"See more" button
                    Button {
                        presentedDetailSheet = .activity
                    } label: {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("See more")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("UncommonRed"))
                            Spacer()
                        }
                        .frame(height: 50)
                        .padding(.top, 10)
                    }
                    //.background(Capsule().foregroundColor(Color("UncommonRed")))

                }.padding().padding(.bottom, 10).background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white)).padding(.horizontal).padding(.bottom)

                Spacer()

            }
                .scrollIndicators(.hidden)
                .navigationTitle(membership.shop.name)
//            .navigationDestination(for: Orders.self) { order in
//                VStack {
//                    Text("order")
//                    Text(order.ids.company)
//                }
////                    Label(membership.company_name, systemImage: "circle.fill")
////                        .font(.headline)
//            }
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

        .sheet(item: $presentedDetailSheet, onDismiss: { presentedDetailSheet = nil }) { [selectedDetailObject] sheet in

            switch sheet {        //customize, stats, activity

            case .customize:
//                EnterName(users_vm: users_vm)
                ChangeCode(codes_vm: codes_vm)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            case .stats:
                EnterName(users_vm: users_vm)
//                Profile()
//                    .presentationDetents([.large])
//                    .presentationDragIndicator(.visible)
            case .activity:
                EnterName(users_vm: users_vm)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            default:
                EnterName(users_vm: users_vm)
            }
        }

        .onAppear {
            self.campaigns_vm.getCampaign(campaign_id: membership.default_campaign.uuid.campaign)
            self.codes_vm.listenForOneCode(code_id: membership.default_campaign.uuid.code)
        }
        .onDisappear {
            if self.codes_vm.one_code_listener != nil {
                self.codes_vm.one_code_listener.remove()
            }
        }
    }

    func renderInCode(code: String) -> Image {

        let renderer = ImageRenderer(content: ReferralCard(cardColor: .blue, textColor: .white, iconPath: membership.uuid.shop, name: membership.shop.name, offer: membership.default_campaign.offer.value, code: codes_vm.one_code.code.code, hasShadow: false))

        // make sure and use the correct display scale for this device
        renderer.scale = displayScale

        if let uiImage = renderer.uiImage {
            //sharePreviewPhoto = Image(uiImage: uiImage)
            //referralCardStruct.image = Image(uiImage: uiImage)

            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.circle")
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



enum PresentedDetailSheet: String, Identifiable {
    case customize, stats, activity
    var id: String {
        return self.rawValue
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
