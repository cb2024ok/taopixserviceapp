//
//  AppDelegate.swift
//  SecondApp
//
//  Created by baby Enjhon on 2020/06/18.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData
import Reachability
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let conn = ConnectionManager.sharedInstance
        conn.observeReachability()
        
        // Notification Category == TEST ==
        // Create the custom actions for the TIMER_EXPIRED category.
        let playAction = UNNotificationAction(identifier: "PLAY",
                                                title: "Accept",
                                                options: [])
        
        let category = UNNotificationCategory(identifier: "GENERAL",
                                                     actions: [playAction],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        
        // for APNS
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        center.delegate = self
        
        
        // For Push Notifications 처리 추가
        // UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        center.requestAuthorization(options: [.alert, .sound, .badge, .carPlay, .criticalAlert]) { granted, _ in
            
            guard granted else {return}
            
                center.getNotificationSettings { settings in
                    print("## Notification Settings : \(settings)")
                    
                    guard settings.authorizationStatus == .authorized else {return}
                    
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
        }
        
        print("Connection Status: \(conn.connected)")

        return true
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to Register Error: \(error.localizedDescription)")
    }
    
    // MARK: -- Get Devices Token --
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            
            let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()     //3
            
            print("------------------Push Token: \(deviceTokenString)---------------------------")
        
        // ## Device 토큰을 저장처리(20201021) ##
        UserDefaults.standard.set(deviceTokenString, forKey: "DeviceToken")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("== Foreground ==")
        
        // list choice only one..
        completionHandler(.list)
        
        // banner
        completionHandler([.banner,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let notification = response.notification
        let userinfo = notification.request.content.userInfo
        
        print("USERINFO: \(userinfo)")
        
        if response.notification.request.content.categoryIdentifier == "GENERAL" {
            
            switch response.actionIdentifier {
                case "PLAY":
                    print("TAOPIX Remote Notication Success!!")
                case UNNotificationDefaultActionIdentifier:
                    print("=== Basic Notification ===")
                    
                        if let url = userinfo["url"] as? String {
                            print("Open Link: \(url)")
                            
                            NotificationCenter.default.post(name: NSNotification.Name("EventDetail"), object: url, userInfo: ["id" : response.actionIdentifier,"url":url])
                        }
                default:
                    break
            }
        }
        print("### Push Receive !!! ###")
        
        completionHandler()
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK : Coredata Framework를 활성화 시킴
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }



}

