//
//  AppDelegate.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 16/04/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       /* let vc1 = UIViewController()
        let vc2 = UIViewController()
        
        vc1.view.backgroundColor = UIColor.cyan
        vc2.view.backgroundColor = UIColor.green*/
        print("test0")
   //     let viewSession = ViewSession(nibName: "ViewSession", bundle: nil)
   //     viewSession.firstViewController = vc1
     //   viewSession.secondViewController = vc2

        print("test3")
        //window? = UIWindow(frame: UIScreen.main.bounds)
        // window = UIWindow(frame: UIScreen.main.bounds)
        //window?.makeKeyAndVisible()
        // window = UIWindow(frame: UIScreen.main.bounds)
      //  window?.rootViewController = viewSession
       // window?.makeKeyAndVisible()
       // window? = UIWindow(frame: UIScreen.main.bounds)
        print("test4")
        //window?.rootViewController = twoTabVC
        print("test4")
        //window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        print("test4")
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

