//
//  AppDelegate.swift
//  uni-tools
//
//  Created by Grant Wei on 7/1/19.
//  Copyright © 2019 Grant Wei. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // ****************************************************************************
        // Initialize Parse SDK
        // ****************************************************************************
        let configuration = ParseClientConfiguration {
            $0.applicationId = "6bff562969344fe047662c1bbb191ac5edbdd719"
            $0.clientKey = "13f9f3814af3517969f743dce73a9b4f1ed21d03"
            $0.server = "http://54.252.183.244:80/parse/"
        }
        Parse.initialize(with: configuration)
        
        PFUser.enableAutomaticUser()
        
        let defaultACL = PFACL()
        defaultACL.hasPublicReadAccess = true // If you would like all objects to be private by default, remove this line.
        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        
        return true
    }
    

//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        let parseConfig = ParseClientConfiguration {
//            $0.applicationId = "6bff562969344fe047662c1bbb191ac5edbdd719"
//            $0.clientKey = "13f9f3814af3517969f743dce73a9b4f1ed21d03"
//            $0.server = "http://54.252.183.244:80/parse/"
//        }
//        Parse.initialize(with: parseConfig)
//    }

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

