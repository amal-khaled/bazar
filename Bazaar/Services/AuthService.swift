//
//  AuthService.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MOLH

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIN : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    func registerUser(email: String, password: String, confirmpassword: String, PhoneNumber: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "email": lowerCaseEmail,
            "password": password,
            "confirmpassword": confirmpassword,
            "PhoneNumber": PhoneNumber
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let message = json["Message"].string {
                    NetworkHelper.saveMessage(message: message)
                }
                self.isLoggedIN = true
                completion(true)
            case .failure(let error):
                completion(false)
                print(error)
            }
        }
    }
    
    func loginUser(username: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = username.lowercased()
        
        let body: [String : Any] = [
            "username": lowerCaseEmail,
            "password": password,
            "grant_type": "password"
        ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER_TOKEN).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let token  = json["access_token"].string {
                    NetworkHelper.saveToken(token: token)
                }
                if let email  = json["userName"].string {
                    NetworkHelper.saveEmail(email: email)
                }
                self.isLoggedIN = true
                completion(true)
            case .failure(let error):
                completion(false)
                print(error)
            }
        }
    }
    
    func editUserInfo(name: String, address: String, phoneNumber: String, email: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "Name": name,
            "Address": address,
            "PhoneNumber": phoneNumber,
            "Email": lowerCaseEmail
        ]
        
        Alamofire.request("\(EDITPROFILE_URL)", method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER_BOTH).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func forgetPassword(email: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "Email": lowerCaseEmail
        ]
        
        Alamofire.request("\(FORGETPASSWORD_URL)", method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
