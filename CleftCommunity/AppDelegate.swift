//
//  AppDelegate.swift
//  CleftCommunity
//
//  Created by ShuaiFu on 15/11/1.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("intlAeJRjQeGEM1FKWmIL9EWpf644z6FNB5yM7w1",
            clientKey: "HOpJNx0vIhyl6k08Lfasx8mAUlO46YfCAGGFOOFJ")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        // Set navigation bar color
        UINavigationBar.appearance().barTintColor = UIColor(red: 100/255.0, green: 149/255.0, blue: 237/255.0, alpha: 0.3)
        UINavigationBar.appearance().tintColor = UIColor.blackColor()
        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 18)!,  NSForegroundColorAttributeName: UIColor.blackColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: 16)!], forState: UIControlState.Normal)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

