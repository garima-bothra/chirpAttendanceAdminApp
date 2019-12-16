//
//  AppDelegate.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 14/10/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit
import Firebase
import ChirpSDK
import GoogleSignIn

var mail : String = ""
var fullName : String = ""
var uid : String = ""
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
   


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
       
        
        
        // Override point for customization after application launch.
        return true
    }

    @available(iOS 9.0, *)
       func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
           let googleDidHandle = GIDSignIn.sharedInstance().handle(url)

           return googleDidHandle
       }

       func application(_ application: UIApplication,open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
           let googleDidHandle = GIDSignIn.sharedInstance().handle(url)

           return googleDidHandle
       }
    
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
            // ...
    //
            if let error = error {
                if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                    print("The user has not signed in before or they have since signed out.")
                } else {
                    print("\(error.localizedDescription)")
                }
                // [START_EXCLUDE silent]
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
                // [END_EXCLUDE]
                return
            }
            // Perform any operations on signed in user here.
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                              accessToken: authentication.accessToken)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let roomsVC = storyboard.instantiateViewController(withIdentifier: "RoomView") as! UIViewController
            self.window?.rootViewController?.present(roomsVC, animated: false, completion: nil)
            let userId = user.userID
            fullName = String(user.profile.name)
        mail = String(user.profile.email)
        uid = Auth.auth().currentUser!.uid
        print(uid)
        print(fullName)
        referadmin = referorgan.child("admin").child(uid)
        referadmin.child("email").setValue(mail)
        referadmin.child("name").setValue(fullName)
        Auth.auth().signIn(with: credential) { (authResult, error) in
             if let error = error {
               // ...
               return
             }
             // User is signed in
             // ...
        
            }
            
            // ...
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
