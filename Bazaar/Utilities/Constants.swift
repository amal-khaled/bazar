//
//  Constants.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import UIKit

typealias CompletionHandler = (_ Success: Bool) -> ()
typealias CompletionHandlerWithMessage = (_ Success: Bool, _ Message: String) -> ()

// User Defaults
let LOGGED_IN_KEY = "loggedIn"

//URL Constants
let REGISTER_WITH_PHONE = "\(BASE_URL)UserSiteAccount/RegisterV2"
let CONFIRM_MOBILE = "\(BASE_URL)UserSiteAccount/ConfirmCodeAndroidV2"

let BASE_URL = "https://bazar-kw.com/"
let REGISTER_URL = "\(BASE_URL)api/Account/Register"
let LOGIN_URL = "\(BASE_URL)/Token"
let Send_Deivce_Token_URL = "\(BASE_URL)api/Account/PostUserDeviceTaken"
let PROFILE_URL = "\(BASE_URL)api/Account/GetUserProfile"
let EDITPROFILE_URL = "\(BASE_URL)api/Account/PostUser"
let FORGETPASSWORD_URL = "\(BASE_URL)api/Account/POSTForgetPassword"
let USER_IMAGE_URL = "\(BASE_URL)api/Account/UserImageUpload"
let HOME_PAGE_URL = "\(BASE_URL)api/Ads/GetHomePage"
let ONE_DAY_AD_URL = "\(BASE_URL)api/TodayShows/GetTodayShows/"
let CITY_URL = "\(BASE_URL)api/Cities"

let ADS_URL = "\(BASE_URL)api/Ads"
let Latest_ADS_URL = "\(BASE_URL)api/Ads/GetLatestAds"
let MOST_VIEWED_ADS_URL = "\(BASE_URL)api/Ads/GetMostViewedAds"
let TOP_ADS_URL = "\(BASE_URL)api/Ads/GetTopAds"
let ALLCATEGORIES_URL = "\(BASE_URL)api/Category/GetCategories?pageIndex=1&total=true"

//GetMostViewedAds
let AD_DETAIL_BY_ID_URL = "\(BASE_URL)api/Ads/"
let FOLLOWUP_AD_BY_ID_URL = "\(BASE_URL)api/Ads/GetFollowUpUserAd/"
let FAVORITE_ADS_URL = "\(BASE_URL)api/Ads/GetUserLovedAds"
let OPENED_ADS_URL = "\(BASE_URL)api/Ads/GetAllOpenedAndPendingAndRejectedAdsOfUser"
let CLOSED_ADS_URL = "\(BASE_URL)api/Ads/GetAllClosedAdsOfUser"
let UNPAYED_ADS_URL = "\(BASE_URL)api/Ads/GetAllUnPayedAdsOfUser"
let SEARCH_URL = "\(BASE_URL)api/Ads/PostSerchedAds"
let UPLOAD_AD_URL = "\(BASE_URL)api/Ads/PostAdAndFiles"
let UPDATE_AD_URL = "\(BASE_URL)api/Ads/UpdateAdAndFiles/"
let ADD_FEATURES_URL = "\(BASE_URL)api/Ads/PostFeaturesToAd"
let ADD_LOVE_BY_ID_URL = "\(BASE_URL)api/Ads/PostUserAdLove/"
let ADD_CALL_BY_ID_URL = "\(BASE_URL)api/Ads/PostCallAdPhone/"
let ADD_WHATSAPP_BY_ID_URL = "\(BASE_URL)api/Ads/PostWhatsappCalls/"
let PAY_URL = "\(BASE_URL)api/Ads/PostPayForAd"
let PAY_ONLINE_URL = "\(BASE_URL)api/Ads/PostPayForAdOnline"
let PAY_FROMPACKAGE_URL = "\(BASE_URL)api/Ads/PostPayForAdFromPackageBalance"
let PAY_PACKAGE_URL = "\(BASE_URL)api/Packages/PostUserPackage"
let ABOUTUS_URL = "\(BASE_URL)api/AboutUs/AboutUsData"

let ALLCATEGORIES_SUB_ADS_URL = "\(BASE_URL)api/Category/GetAllCategoriesWithSubCategoriesAndSomeAdsWithPagination"
let CAT_SUBCATEGORY_ADS_BY_ID_URL = "\(BASE_URL)api/Category/GetCategorySubCategoriesAndAds/"
let SUB_SUBCATEGORY_ADS_BY_ID_URL = "\(BASE_URL)api/SubCategory/GetSubcategorySubsubcategoriesAndAds/"
let SUBSUBCATEGORY_ADS_BY_ID_URL = "\(BASE_URL)api/SubCategory/GetSubsubcategoryAndAds/"
let CITES_URL = "\(BASE_URL)api/Cities"
let CONTACTUS_URL = "\(BASE_URL)api/ContactUsMessages"
let FEATURES_URL = "\(BASE_URL)api/Features"
let UNSELECTEDـFEATURES_URL = "\(BASE_URL)api/Ads/"

let PACKAGES_URL = "\(BASE_URL)api/Packages"
let PDFS_URL = "\(BASE_URL)api/PDFs"
let QUESTIONS_URL = "\(BASE_URL)api/Questions"
let SUBMIT_QUESTIONS_URL = "\(BASE_URL)api/Questions"
let TERMS_URL = "\(BASE_URL)api/Terms/TermsData"
let AD_REPORT = "\(BASE_URL)api/UserAdReports"
let PACKEGES_HISTORY_URL = "\(BASE_URL)api/UserPackagesPaymentHistories"
let PAYMENT_HISTORY_URL = "\(BASE_URL)api/UserAdsPaymentHistories"
let ADD_PACKAGE_URL = "\(BASE_URL)api/Packages/PostUserPackage"
let NOTIFICATION_URL = "\(BASE_URL)api/Notifications/GetMyNotifications"
let PAYMENTMETHODFORAD_URL = "\(BASE_URL)api/Ads/PostPayForAdOnline"
let EXECUTEPAYMENTMETHODFORAD_URL = "\(BASE_URL)api/Ads/PostExcutePayForAdOnline"
let PAYMENTMETHODFORPACKAGE_URL = "\(BASE_URL)api/Packages/PostUserPackage"
let EXECUTEPAYMENTMETHODFORPACKAGE_URL = "\(BASE_URL)api/Packages/PostExcuteUserPackage"
let RESETPASS_URL = "\(BASE_URL)api/Account/POSTResetPasswordForAndroid"
let TOKEN_URL = "\(BASE_URL)api/Account/PostUserDeviceTaken"

let COMMERICAL_ADS_URL = "\(BASE_URL)api/CommericalAds/GetCommericalAds"
let COMMERICAL_ADS_LIKES = "\(BASE_URL)api/CommericalAds/PostCommircalAdLikE/"
let COMMERICAL_ADS_DETAILS = "\(BASE_URL)api/CommericalAds/GetCommericalAdDetails/"
let SliderADS = "\(BASE_URL)api/Ads/GetSliderAds?page=1&CityId="
let ALL_PRODUCTS = "\(BASE_URL)api/Products/GetAllProducts/"
let SEND_ORDER = "\(BASE_URL)api/ApiOrders"
let PAYMENT_LIST = "\(BASE_URL)api/ApiOrders/PostPayForOrder/"
let PAYMENT_LINK = "\(BASE_URL)api/ApiOrders/PostExcutePayForOrder"
let MY_ORDERS = "\(BASE_URL)api/ApiOrders/GetUserOrders"
let CANCEL_ORDERS = "\(BASE_URL)api/ApiOrders/PostDeleteOrder/"
let GOVERNERATE = "\(BASE_URL)api/APIGovernerates/"
let AREA = "\(BASE_URL)api/APIAreas/"
let REMOVE_AD = "\(BASE_URL)api/Ads/PostDeleteAd/"
let REMOVE_AD_IMAGE = "\(BASE_URL)api/Ads/DeleteAdFile?FileBankId="

//

// Headers
let HEADER = [
    "Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"
]
let HEADER_TOKEN = [
    "Content-Type" : "text/plain; charset=utf-8"
]
var HEADER_AUTH = [
    "Authorization" : "bearer \(String(describing: NetworkHelper.getToken()!))"
]
var HEADER_BOTH = [
    "Authorization" : "bearer \(String(describing: NetworkHelper.getToken() ?? ""))",
    "Content-Type" : "application/x-www-form-urlencoded; charset=utf-8"
]
var HEADER_JSON = [
    "Authorization" : "bearer \(String(describing: NetworkHelper.getToken()!))",
    "Content-Type" : "application/json; charset=utf-8"
]

func createErrorAlert(msg: String, vc: UIViewController){
    let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
    vc.present(alert, animated: true, completion: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    })
}
