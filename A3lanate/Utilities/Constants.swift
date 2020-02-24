//
//  Constants.swift
//  A3lanate
//
//  Created by Mahmoud Elshakoushy on 2/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// User Defaults
let LOGGED_IN_KEY = "loggedIn"

//URL Constants
let BASE_URL = "http://a3lanate.com/"
let REGISTER_URL = "\(BASE_URL)api/Account/Register"
let LOGIN_URL = "\(BASE_URL)/Token"
let PROFILE_URL = "\(BASE_URL)api/Account/GetUserProfile"
let USER_IMAGE_URL = "\(BASE_URL)api/Account/UserImageUpload"
let HOME_PAGE_URL = "\(BASE_URL)api/Ads/GetHomePage"
let ADS_URL = "\(BASE_URL)api/Ads"
let AD_DETAIL_BY_ID_URL = "\(BASE_URL)api/Ads/"
let FOLLOWUP_AD_BY_ID_URL = "\(BASE_URL)api/Ads/GetFollowUpUserAd/"
let FAVORITE_ADS_URL = "\(BASE_URL)api/Ads/GetUserLovedAds"
let OPENED_ADS_URL = "\(BASE_URL)api/Ads/GetAllOpenedAndPendingAndRejectedAdsOfUser"
let CLOSED_ADS_URL = "\(BASE_URL)api/Ads/GetAllClosedAdsOfUser"
let UNPAYED_ADS_URL = "\(BASE_URL)api/Ads/GetAllUnPayedAdsOfUser"
let SEARCH_URL = "\(BASE_URL)api/Ads/PostSeßrchedAds"
let UPLOAD_AD_URL = "\(BASE_URL)api/Ads/PostAdAndFiles"
let ADD_FEATURES_URL = "\(BASE_URL)api/Ads/PostFeaturesToAd"
let ADD_LOVE_BY_ID_URL = "\(BASE_URL)api/Ads/PostUserAdLove/"
let ADD_CALL_BY_ID_URL = "\(BASE_URL)api/Ads/PostCallAdPhone/"
let ADD_WHATSAPP_BY_ID_URL = "\(BASE_URL)api/Ads/PostWhatsappCalls/"
let ABOUTUD_URL = "\(BASE_URL)api/AboutUs/AboutUsData"
let ALLCATEGORIES_SUB_ADS_URL = "\(BASE_URL)api/Category/GetAllCategoriesWithSubCategoriesAndSomeAds"
let CAT_SUBCATEGORY_ADS_BY_ID_URL = "\(BASE_URL)api/Category/GetCategorySubCategoriesAndAds/"
let SUB_SUBCATEGORY_ADS_BY_ID_URL = "\(BASE_URL)api/SubCategory/GetSubcategorySubsubcategoriesAndAds/"
let SUBSUBCATEGORY_ADS_BY_ID_URL = "\(BASE_URL)api/SubCategory/GetSubsubcategoryAndAds/"
let CITES_URL = "\(BASE_URL)api/Cities"
let CONTACTUS_URL = "\(BASE_URL)api/ContactUsMessages"
let FEATURES_URL = "\(BASE_URL)api/Features"
let PACKAGES_URL = "\(BASE_URL)api/Packages"
let PDFS_URL = "\(BASE_URL)api/PDFs"
let QUESTIONS_URL = "\(BASE_URL)api/Questions"
let SUBMIT_QUESTIONS_URL = "\(BASE_URL)api/Questions"
let TERMS_URL = "\(BASE_URL)api/Terms/TermsData"
let AD_REPORT = "\(BASE_URL)api/UserAdReports"
let PACKEGES_HISTORY_URL = "\(BASE_URL)api/UserPackagesPaymentHistories"
let PAYMENT_HISTORY_URL = "\(BASE_URL)api/UserAdsPaymentHistories"
let ADD_PACKAGE_URL = "\(BASE_URL)api/Packages/PostUserPackage"


// Headers
let HEADER = [
    "Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"
]
let HEADER_TOKEN = [
    "Content-Type" : "text/plain; charset=utf-8"
]
let HEADER_AUTH = [
    "Authorization" : "bearer \(String(describing: NetworkHelper.getToken()!))"
]
let HEADER_BOTH = [
    "Authorization" : "bearer \(String(describing: NetworkHelper.getToken()!))",
    "Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"
]
