//
//  SceneDelegate.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 04/03/2021.
//

import UIKit
import FirebaseCore
import NotificationCenter

var userDefaults = UserDefaults.standard
let center = UNUserNotificationCenter.current()

class SceneDelegate: UIResponder, UIWindowSceneDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var timer = Timer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if UserDefaults.standard.string(forKey: "firstMotiviaLaunch") == nil {
            userDefaults.set("done", forKey: "firstMotiviaLaunch")
            UserDefaults.standard.setValue("1", forKey: "themeImg")
        }
        
        
        if UserDefaults.standard.string(forKey: "userId") != nil {
            if let windowScene = scene as? UIWindowScene {
                self.window = UIWindow(windowScene: windowScene)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "QuotesViewController")
                self.window!.rootViewController = initialViewController
                self.window!.makeKeyAndVisible()
            }
        }
        UIApplication.shared.registerForRemoteNotifications()
        center.delegate = self
        center.requestAuthorization(options: [.alert,.badge,.sound]) { (success, error) in
            
        }
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//
//        timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { [weak self] _ in
//
//
//        }
        center.getPendingNotificationRequests { (not) in
            self.setupNotification(title: "Today's Quote", body: "Tap to see your today's quotation.")
        }
//
        setupNotification(title: "Today's Quote", body: "Tap to see your today's quotation.")
        
//        center.getDeliveredNotifications { (not) in
//            self.setupNotification(title: "Today's Quote", body: "Tap to see your today's quotation.")
//        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        self.setupNotification(title: "Today's Quote", body: "Tap to see your today's quotation.")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //        DispatchQueue.main.async {
        //            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        //            let controller1VC = storyboard.instantiateViewController(withIdentifier: "QuoteFeelingVC") as! QuoteFeelingVC
        //            controller1VC.isNotification = true
        //            let tabBar = self.window?.rootViewController as? UITabBarController
        //            let nav = tabBar?.selectedViewController as? UINavigationController
        //            nav?.pushViewController(controller1VC, animated: true)
        //        }
    }
    
    
    func setupNotification(title: String, body: String){
        let quote = ["title": "tile", "body":"body\(getCurrentTime())"]
        let content = UNMutableNotificationContent()
        content.title = quote["title"]!
        content.body = quote["body"]!
        content.sound = UNNotificationSound.default
        //        var dateComponents = DateComponents()
        //        dateComponents.hour = 16
        //        dateComponents.minute = 29
        let ri = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: ri)
        center.add(request)
        
        
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

