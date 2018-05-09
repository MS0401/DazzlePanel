//
//  AppDelegate.swift
//  DazzlePanel
//
//  Created by For on 5/23/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import WYPopoverController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var postTimer: Timer?
    var scheduleTimer: Timer?
    var timelineTimer: Timer?
    var countTimer: Timer?
    var otherLocationTimer: Timer?
    var tokenTimer: Timer?
    
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyDKPYSGdH10ali3QSQ7U0cXq7xyxzxR6Cg")
        GMSPlacesClient.provideAPIKey("AIzaSyDKPYSGdH10ali3QSQ7U0cXq7xyxzxR6Cg")
        
//        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
//        application.beginBackgroundTask(withName: "showNotification", expirationHandler: nil)
        
        
        
        // setup navBar.....
        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 26)]
        
        //WYPopoverController definition.
        let popoverAppearance: WYPopoverBackgroundView = WYPopoverBackgroundView.appearance()
        popoverAppearance.arrowHeight = 15
        popoverAppearance.arrowBase = 15
        popoverAppearance.borderWidth = 7
        popoverAppearance.outerCornerRadius = 15
        popoverAppearance.outerStrokeColor = UIColor.init(netHex: 0xF99B34)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

