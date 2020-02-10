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
