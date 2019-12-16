//
//  ViewController.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 14/10/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

var refer = Database.database().reference();
var adminName : String = "";
var referadmin = Database.database().reference().child("Admin")
var referorgan = Database.database().reference()
var referroom = Database.database().reference()

class ViewController: UIViewController {

  
   
    @IBOutlet weak var incorrectUsernameNotification: UITextField!
    @IBOutlet weak var passwordEntered: UITextField!
    @IBOutlet weak var usernameEntered: UITextField!
    
     @IBAction func loginButtonPressed(_ sender: UIButton) {
        
       
        refer.child("organization").child(usernameEntered.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
           
            let value = snapshot.value as? NSDictionary
             let key = value?["authKey"] as? String ?? ""
            let password = value?["authPassword"] as? String ?? ""
                print(key)
              print(password);
            if(password==self.passwordEntered.text!){
                referorgan = refer.child("organization").child(key)
                GIDSignIn.sharedInstance()?.presentingViewController = self
                    //GIDSignIn.sharedInstance()?.restorePreviousSignIn()

                    GIDSignIn.sharedInstance().signIn()
                  

                    if ((GIDSignIn.sharedInstance()?.currentUser) != nil){
                        print("\(String(describing: GIDSignIn.sharedInstance()?.currentUser))")
                        print("122");

                        referadmin = Database.database().reference().child("organization").child(self.usernameEntered.text!).child("Admin").child(fullName)
                        
                        
                self.performSegue(withIdentifier: "goToRoom", sender: self)
                adminName=fullName
                print(adminName)
                }
            }
            else
            {
                self.incorrectUsernameNotification.text = "Incorrect username/password";
                self.usernameEntered.text = nil
                self.passwordEntered.text = nil
            }
    })
    
    
}
}

