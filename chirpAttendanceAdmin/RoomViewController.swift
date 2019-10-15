//
//  RoomViewController.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 14/10/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit



class RoomViewController: UIViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func makeRoomButtonPressed(_ sender: Any) {
    
        self.performSegue(withIdentifier: "goToRoomForm", sender: (Any).self)
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}

