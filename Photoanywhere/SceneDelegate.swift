//
//  SceneDelegate.swift
//  SecondApp
//
//  Created by baby Enjhon on 2020/06/18.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        
        let settings = UserSettings()
        
        if UserDefaults.contains("token") {
            let vUserToken = UserDefaults.standard.value(forKey: "token") as! String
            let vUserID = UserDefaults.standard.value(forKey: "userid") as! String
            
            print("User Token: \(vUserToken) - ID: \(vUserID)")
            // 사용자 Static Data Load
            settings.Usertoken = vUserToken
            settings.UserID = vUserID
            settings.loggedIn = true
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // UserAdd View에 추가
        //LoginView( errorReason: "").environmentObject(settings)
        
        //let contentView = StartView().environment(\.managedObjectContext, context)
        //contentView.environmentObject(settings)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: StartView().environmentObject(settings)
                .environment(\.managedObjectContext, context)
            ) //UIHostingController(rootView: contentView)
            self.window = window
            window.overrideUserInterfaceStyle = .light
            window.makeKeyAndVisible()
        }
        
        /*
        let appNavigationController = UINavigationController.init(rootView: StartView().environmentObject(settings) as! AnyView)
    
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = appNavigationController
            self.window = window
            window.makeKeyAndVisible()
        }
        */
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension UserDefaults {
    static func contains(_ key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
