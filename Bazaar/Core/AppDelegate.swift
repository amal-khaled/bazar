//
//  AppDelegate.swift
//  Bazar
//
//  Created by Mahmoud Elshakoushy.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import SideMenuSwift
import MOLH
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    static var deviceToken = ""
    static var cityId = 1
    static var countries = [country]()
    static var defaults:UserDefaults = UserDefaults.standard
    static var cart = Cart()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIFont.overrideInitialize()
        
        UtilitiesService.instance.getCounties(completion: {
            check, countries in
            if check == 0 {
                AppDelegate.countries = countries
                if AppDelegate.defaults.string(forKey: "cityId") != nil{
                    
                    AppDelegate.cityId = Int(AppDelegate.defaults.string(forKey: "cityId") ?? "0")!
                }else{
                    let index = AppDelegate.countries.firstIndex(where: {$0.nameEn == "Kuwait"}) ?? 0
                    AppDelegate.cityId = AppDelegate.countries[index].id
                    AppDelegate.defaults.setValue(AppDelegate.cityId, forKey: "cityId")
                    
                }
                
            }
        })
        // Override point for customization after application launch.
        if let _ = AppDelegate.defaults.object(forKey: "cart") as? Data {
            AppDelegate.cart = AppDelegate.cart.getCart()
            print( AppDelegate.cart.price)
            for product in AppDelegate.cart.products{
                print(product.name)
                print(product.price)
                print(product.quanityInsideCart)
                
            }
        }
        
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        configureSideMenu()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Auth.auth().languageCode = MOLHLanguage.currentAppleLanguage()
        MOLH.shared.activate(true)
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        //        MOLH.setLanguageTo("ar")
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9803921569, green: 0.7333333333, blue: 0.3176470588, alpha: 1) , NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)]  , for: .selected)
//        Thread.sleep(forTimeInterval: 2.0)
//        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//            if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
//                statusBar.backgroundColor = UIColor(named: "main_color")
//            }
//
//        if #available(iOS 13.0, *) {
//                 let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//                 // Reference - https://stackoverflow.com/a/57899013/7316675
//                 let statusBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
//                 statusBar.backgroundColor = UIColor(named: "main_color")
//                 window?.addSubview(statusBar)
//          }
        Messaging.messaging().subscribe(toTopic: "/topics/all_users") { error in
            print("Subscribed to weather topic")
        }
        
        
        
        if AppDelegate.defaults.string(forKey: "cityId") != nil{
            
            AppDelegate.cityId = Int(AppDelegate.defaults.string(forKey: "cityId") ?? "1") ?? 1
        }
        
        return true
    }
    
    @available(iOS 13.0, *)
    func swichRoot(){
        //Flip Animation before changing rootView
        animateView()
        
        // switch root view controllers
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "mainTabBar")
        
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window!.rootViewController = nav
        }
        
    }
    @available(iOS 13.0, *)
    func animateView() {
        var transition = UIView.AnimationOptions.transitionFlipFromRight
        if !MOLHLanguage.isRTLLanguage() {
            transition = .transitionFlipFromLeft
        }
        animateView(transition: transition)
    }
    
    @available(iOS 13.0, *)
    func animateView(transition: UIView.AnimationOptions) {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate {
            UIView.transition(with: (((delegate as? SceneDelegate)!.window)!), duration: 0.5, options: transition, animations: {}) { (f) in
            }
        }
    }
    
    private func configureSideMenu() {
        SideMenuController.preferences.basic.menuWidth = 330
        SideMenuController.preferences.basic.position = .sideBySide
        if MOLHLanguage.isArabic() {
            SideMenuController.preferences.basic.direction = .right
        } else {
            SideMenuController.preferences.basic.direction = .left
        }
    }
    
    func reset() {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let stry = UIStoryboard(name: "Main", bundle: nil)
        rootviewcontroller.rootViewController = stry.instantiateViewController(withIdentifier: "mainTabBar")
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        
        print(userInfo)
       

        let notification = NotificationN()
        notification.Title = userInfo[AnyHashable("Title")] as! String
        notification.TitleEN = userInfo[AnyHashable("TitleEN")] as! String
        notification.Body = userInfo[AnyHashable("Body")] as! String
        notification.BodyEN = userInfo[AnyHashable("BodyEN")] as! String
        if let _adId = userInfo[AnyHashable("AdId")] as? Int{
            notification.AdId = _adId
            
        }
        if let _adId = userInfo[AnyHashable("AdId")] as? Int{
            notification.AdId = _adId
            
        }
        if let _adId = userInfo[AnyHashable("CommericalAdId")] as? Int{
            notification.CommericalAdId = _adId
            
        }
        
        notification.Date = userInfo[AnyHashable("Date")] as! String
        notification.type = userInfo[AnyHashable("Type")] as! Int
        
        if notification.type == 0{
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openAd"), object: nil, userInfo: ["adId":  notification.AdId ])
            
        }else if notification.type == 2{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openCom"), object: nil, userInfo: ["adId":  notification.CommericalAdId])
            
        }else if notification.type == 1{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "opeenBalance"), object: nil)
        }
        
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        //        InstanceID.instanceID().instanceID { result, error in
        //            if let error = error {
        //                print("Error fetching remote instange ID: \(error)")
        //            } else if let result = result {
        //                print("Remote instance ID token: \(result.token)")
        //            }
        //        }
        AppDelegate.deviceToken = fcmToken ?? ""
        print(fcmToken)
        AuthService.instance.sendToken(token: AppDelegate.deviceToken)
    }
    
    //    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    //        print("Message Data: ", remoteMessage.appData)
    //    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
        
        
        completionHandler(UIBackgroundFetchResult.newData)
        // This notification is not auth related, developer should handle it.
    }
    //    func application(_ application: UIApplication, open url: URL,
    //        options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    //      if Auth.auth().canHandle(url) {
    //        return true
    //      }
    //      // URL not auth related, developer should handle it.
    //    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if Auth.auth().canHandle(url) {
            return true
        }
        return true
    }
}
