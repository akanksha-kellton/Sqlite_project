//
//  AppDelegate.swift
//  SQLiteDemo
//
//  Created by IOS Training 2 on 20/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let defaults = UserDefaults.standard


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
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
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return
    }
    
    private func storeDataIntoUserDefaults() {
            //Game App
//            defaults.set("Akanksha", forKey: UserDefaultKeys.name.rawValue)
//        defaults.set("akanksha.p@gmail.com", forKey: UserDefaultKeys.emailid.rawValue)//Int
//            defaults.set(123456789, forKey: UserDefaultKeys.mobile.rawValue)//Float
            
            
//            let weapons = ["Assault Rifles", "DMRs", "Submachine Guns", "Sniper Rifles", "Light Machine Guns"]
//            defaults.set(weapons, forKey: UserDefaultKeys.weapons.rawValue)
//
//            //Dictionary
//            let otherUserWithNickNames = ["Virat": "Alvin", "Hardik": "Kung Fu Pandya", "Rohit": "Snipper007"]
//            defaults.set(otherUserWithNickNames, forKey: UserDefaultKeys.otherUserWithNickNames.rawValue)
        }




}

