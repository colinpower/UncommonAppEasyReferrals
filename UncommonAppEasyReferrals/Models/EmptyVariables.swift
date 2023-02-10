//
//  EmptyVariables.swift
//  UncommonAppEasyReferrals
//
//  Created by Colin Power on 1/20/23.
//

import Foundation

class EmptyVariables {
    
    var empty_user = Users(profile: Struct_Profile(email: "", email_verified: false, name: Struct_Profile_Name(first: "", last: ""), phone: "", phone_verified: false), settings: Users_Settings(has_notifications: false), timestamp: Users_Timestamp(created: 0, deleted: 0), uuid: Users_UUID(user: ""))
        
    var empty_stripe_account = Stripe_Accounts(account: Stripe_Accounts_Account(acct_id: "", balance: 0, link: Stripe_Accounts_Account_Link(created: 0, object: "", url: ""), methods_available: [], source_type: ""), profile: Struct_Profile(email: "", email_verified: false, name: Struct_Profile_Name(first: "", last: ""), phone: "", phone_verified: false), setup: Stripe_Accounts_Setup(charges_enabled: false, currently_due: [], details_submitted: false, eventually_due: [], link: ""), timestamp: Stripe_Accounts_Timestamp(created: 0, last_updated: 0), uuid: Stripe_Accounts_UUID(stripe_account: "", user: ""))
        
    var empty_campaign = Campaigns(_STATUS: "", commission: Struct_Commission(duration_pending: 0, offer: "", type: "", value: ""), color: [], offer: Struct_Offer(one_per_customer: false, minimum_spend: 0, offer: "", type: "", timestamp: Struct_Offer_Timestamp(expires: 0, starts: 0), total_usage_limit: 0, value: ""), requirements: Campaigns_Requirements(customers_only: false, referral_count: 0, users: []), timestamp: Campaigns_Timestamp(created: 0, expires: 0, starts: 0), title: "", uuid: Campaigns_UUID(campaign: "", shop: ""))
    
    var empty_code = Codes(_PURPOSE: "", code: Struct_Code(code: "", UPPERCASED: "", color: [], graphql_id: "", is_default: false), shop: Struct_Shop(category: "", contact_support_email: "", description: "", domain: "", name: "", website: ""), stats: Codes_Stats(usage_count: 0, usage_limit: 0), status: "", timestamp: Codes_Timestamp(created: 0, deleted: 0, last_used: 0, pending: 0), uuid: Struct_UUID(campaign: "", cash: "", code: "", membership: "", order: "", referral: "", reward_code: "", shop: "", user: ""))
    
    var empty_membership = Memberships(campaigns: [], color: [], default_campaign: Memberships_DefaultCampaign(commission: Struct_Commission(duration_pending: 0, offer: "", type: "", value: ""), offer: Struct_Offer(one_per_customer: false, minimum_spend: 0, offer: "", type: "", timestamp: Struct_Offer_Timestamp(expires: 0, starts: 0), total_usage_limit: 0, value: ""), uuid: Memberships_DefaultCampaign_UUID(code: "", campaign: "")), shop: Struct_Shop(category: "", contact_support_email: "", description: "", domain: "", name: "", website: ""), shopify_customer_id: "", status: "", timestamp: Memberships_Timestamp(created: 0, disabled: 0), uuid: Struct_UUID(campaign: "", cash: "", code: "", membership: "", order: "", referral: "", reward_code: "", shop: "", user: ""))
    
    var empty_shop = Shops(_STATUS: "", profile: Struct_Profile(email: "", email_verified: false, name: Struct_Profile_Name(first: "", last: ""), phone: "", phone_verified: false), campaigns: [], shop: Struct_Shop(category: "", contact_support_email: "", description: "", domain: "", name: "", website: ""), timestamp: Shops_Timestamp(created: 0, deleted: 0), uuid: Shops_UUID(shop: ""))
    
    var empty_codeupdate = CodeUpdates(code: Struct_Code(code: "", UPPERCASED: "", color: [], graphql_id: "", is_default: false), new_code: "", shop: Struct_Shop(category: "", contact_support_email: "", description: "", domain: "", name: "", website: ""), status: "", timestamp: CodeUpdates_Timestamp(created: 0, updated: 0), uuid: "")
    
    var empty_referral = Referrals(_STATUS: "", code: "", commission: Struct_Commission(duration_pending: 0, offer: "", type: "", value: ""), revenue: "", shop: Struct_Shop(category: "", contact_support_email: "", description: "", domain: "", name: "", website: ""), status: "", modified_by: "", timestamp: Referrals_Timestamp(completed: 0, created: 0, deleted: 0, flagged: 0, returned: 0), uuid: Struct_UUID(campaign: "", cash: "", code: "", membership: "", order: "", referral: "", reward_code: "", shop: "", user: ""))
    
}
