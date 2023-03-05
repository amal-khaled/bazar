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
    
    func registerUser(email: String, password: String, confirmpassword: String, PhoneNumber: String, cityID: Int, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "email": lowerCaseEmail,
            "password": password,
            "confirmpassword": confirmpassword,
            "PhoneNumber": PhoneNumber,
            "cityId": cityID,
        ]
       
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
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
    func registerUserWithPhone( password: String, PhoneNumber: String, cityID: Int, completion: @escaping CompletionHandlerWithMessage) {
        
        
        let body: [String : Any] = [
            "password": password,
            "phone": PhoneNumber,
            "cityId": cityID,
            "isApi": "true",
        ]
        
        Alamofire.request(REGISTER_WITH_PHONE, method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
//                let json = JSON(value)
//                if let message = json["Message"].string {
//                    NetworkHelper.saveMessage(message: message)
//                }
//                self.isLoggedIN = true
//                completion(true)
                let json = value as! NSDictionary

                let status = json["status"] as! Int
                
                if status == 500{
                    completion(false, "this phone already exist you ... go to login".localized)
                }
                else{
                    completion(true,"")
                }
            case .failure(let error):
                completion(false, "something went wrong ... try again later".localized)
                print(error)
            }
        }
    }
    
    func loginUser(username: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = username.lowercased()
        
        let body: [String : Any] = [
            "userName": lowerCaseEmail,
            "password": password,
            "grant_type": "password",
            "loginMethod": "email",
        ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER_TOKEN).responseJSON { (response) in
            switch response.result {
            
            case .success(let value):
                let json = JSON(value)
                print(json)
                if let token  = json["access_token"].string {
                    AuthService.instance.sendToken(token: AppDelegate.deviceToken)

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
    func loginUserWithPhone(phone: String, password: String,cityID: String, completion: @escaping CompletionHandler) {
        
        
        let body: [String : Any] = [
            "phone": phone,
            "password": password,
            "cityId": cityID,
            "grant_type": "password",
            "loginMethod": "phone",
            "userName": "",
            "isApi": "true",

        ]
        print(body)
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER_TOKEN).responseJSON { (response) in
            print(response.result.value)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                if let token  = json["access_token"].string {
                    AuthService.instance.sendToken(token: AppDelegate.deviceToken)

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
    
    func cofirmMobile( checkCode: String, phone: String, cityId: String,password:String,  completion: @escaping CompletionHandlerWithMessage) {
        
        
        let body = [
            "phone": phone,

            "code": checkCode,
            "isApi": "true",
            "cityId": cityId,
            "password": password,
            "isConfirm": "true",
            "sid":"sid",]
            
        
            print(CONFIRM_MOBILE)
        print(body)
            
        Alamofire.request("\(CONFIRM_MOBILE)", method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            print(response.result.value)
            switch response.result {
            
            case .success(let value):
               
                
                let json = value as! NSDictionary

                let status = json["status"] as! Int
                
                if status == 200{
                    completion(true,"")

                }
                else{
                    completion(false, "try again later".localized)

                }
                

            case .failure(let error):
                print(error)

                completion(false, "something went wrong ... try again later".localized)
            }
        }
    }
    
    
    func editUserInfo(name: String, address: String, phoneNumber: String, email: String, cityID: Int, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "Name": name,
            "Address": address,
            "PhoneNumber": phoneNumber,
            "Email": lowerCaseEmail,
            "CityId": cityID
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
    
    func forgetPassword(email: String, completion: @escaping CompletionHandlerWithMessage) {
        
//        let lowerCaseEmail = email.lowercased()
        
        let body: Parameters = [
            "Email": email,
            "Type": "email",
            "Phone": "",
            "IsApi": "true",
        ]
       
        print(body)
        Alamofire.request("\(FORGETPASSWORD_URL)", method: .post, parameters: body, headers: HEADER).responseJSON { (response) in
            print(response.result.value)
            if response.result.error == nil {
                let json = response.result.value as! NSDictionary

                if let flag = json["Flag"] as? Bool{
                    if !flag {
                        completion(false, "Email is Wrong".localized)

                    }else{
                        completion(true, "")

                    }
                }
            } else {
                completion(false, "something went wrong ... try again later".localized)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func resetPassword(email: String, checkCode: String, pass: String, completion: @escaping CompletionHandlerWithMessage) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "Email": lowerCaseEmail,
            "CheckCode": checkCode,
            "Password": pass,
            "ConfirmPassword": pass,
            "Type": "email",
            "IsApi": "true",

        ]
        
        Alamofire.request("\(RESETPASS_URL)", method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                let json = response.result.value as! NSDictionary

                if let flag = json["Flag"] as? Bool{
                    if !flag {
                        completion(false, "code is Wrong".localized)

                    }else{
                        completion(true, "")

                    }
                }
                
            } else {
                completion(false, "something went wrong ... try again later".localized)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func forgetPasswordWithPhone(phone: String, completion: @escaping CompletionHandlerWithMessage) {
        
//        let lowerCaseEmail = email.lowercased()
        
        let body: Parameters = [
            "Email": "" ,
            "Type": "phone",
            "Phone": phone,
            "IsApi": "true",
        ]
       
        print(body)
        Alamofire.request("\(FORGETPASSWORD_URL)", method: .post, parameters: body, headers: HEADER).responseJSON { (response) in
            print(response.result.value)
            if response.result.error == nil {
                let json = response.result.value as! NSDictionary

                if let flag = json["Flag"] as? Bool{
                    if !flag {
                        completion(false, "Phone is Wrong".localized)

                    }else{
                        completion(true, "")

                    }
                }
            } else {
                completion(false, "something went wrong ... try again later".localized)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func resetPasswordWithPhone(phone: String, checkCode: String, pass: String, completion: @escaping CompletionHandlerWithMessage) {
        
        let body: [String : Any] = [
            "Phone": phone,
            "CheckCode": checkCode,
            "Password": pass,
            "ConfirmPassword": pass,
            "Type": "phone",
            "IsConfirm": "true",
            "sid":"sid"
        ]
        print(body)

        print(RESETPASS_URL)
        Alamofire.request("\(RESETPASS_URL)", method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER).responseJSON { (response) in
            print(response.result.value)
            if response.result.error == nil {
                let json = response.result.value as! NSDictionary

                if let flag = json["Flag"] as? Bool{
                    if !flag {
                        completion(false, "code is Wrong".localized)

                    }else{
                        completion(true, "")

                    }
                }
                
            } else {
                completion(false, "something went wrong ... try again later".localized)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func sendToken(token: String) {
        
        
        let body: [String : Any] = [
            "DeviceTaken": token,
          
        ]
        
        Alamofire.request(Send_Deivce_Token_URL, method: .post, parameters: body, encoding: URLEncoding.default, headers: HEADER_BOTH).responseJSON { (response) in
           print(response.result)
        }
    }
}
