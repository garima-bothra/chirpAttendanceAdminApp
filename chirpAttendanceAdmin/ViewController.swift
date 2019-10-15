//
//  ViewController.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 14/10/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit
import Firebase


var refer = Database.database().reference();
var adminName : String = "";


class ViewController: UIViewController {

  
   
    @IBOutlet weak var incorrectUsernameNotification: UITextField!
    @IBOutlet weak var passwordEntered: UITextField!
    @IBOutlet weak var usernameEntered: UITextField!
    
     @IBAction func loginButtonPressed(_ sender: UIButton) {
        
       
        refer.child("Admin").child(usernameEntered.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let password = value?["authPassword"] as? String ?? ""
              print(password);
            if(password==self.passwordEntered.text!){
                self.performSegue(withIdentifier: "goToRoom", sender: self)
                adminName=self.usernameEntered.text!
                print(adminName)
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

