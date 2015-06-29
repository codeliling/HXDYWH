//
//  AppDelegate.swift
//  dywh
//
//  Created by lotusprize on 15/3/10.
//  Copyright (c) 2015年 geekTeam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mapManager: BMKMapManager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var statTracker:BaiduMobStat = BaiduMobStat.defaultStat()
        statTracker.enableExceptionLog = true
        statTracker.logStrategy = BaiduMobStatLogStrategyCustom
        statTracker.logSendInterval = 1
        statTracker.logSendWifiOnly = true
        statTracker.sessionResumeInterval = 10
        statTracker.enableDebugOn = true
        statTracker.startWithAppId("a358344ffc")
        
        mapManager = BMKMapManager()
        mapManager?.start("ksRAoNWuCSloyKb3ImbOqbgk", generalDelegate: nil)
        
        UMSocialData.setAppKey("556a5c3e67e58e57a3003c8a")
        UMSocialWechatHandler.setWXAppId("wx6567681abede8c20", appSecret: "853182c62c7e1f2d6398479cdd482bfe", url: "http://www.umeng.com/social");
        UMSocialQQHandler.setQQWithAppId("1104737822", appKey: "q13dhXSo7j2uDLeP", url: "http://www.umeng.com/social")
        UMSocialData.defaultData().extConfig.wxMessageType = UMSocialWXMessageTypeApp
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
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    


}

