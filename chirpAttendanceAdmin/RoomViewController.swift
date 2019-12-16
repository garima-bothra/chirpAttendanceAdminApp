//
//  RoomViewController.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 14/10/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit
import Firebase


class RoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
//    var referroom = refer.child("rooms").child(String(hashed))
    var meetArray : [Meeting] = [Meeting]()
    @IBOutlet weak var meetingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        meetingsTableView.register(UINib(nibName: "MeetCell", bundle: nil), forCellReuseIdentifier: "MeetingCell")
        configureTableView()
        retrievemeetings()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingCell", for: indexPath) as! CustomMeetinggCell
      
        
        cell.meetingName.text = meetArray[indexPath.row].agenda
        cell.meetingDate.text = String(createDateTime(timestamp: meetArray[indexPath.row].startingUnixTime).prefix(10))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        referroom = meetArray[indexPath.row].referroom
        print(referroom)
        self.performSegue(withIdentifier: "goToAttendees", sender: (Any).self)
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return meetArray.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meetArray.count
    }
    
    func retrievemeetings()
    {
        referadmin.child("rooms").observe(DataEventType.value, with:{ (snapshot) in
            for snap in snapshot.children.allObjects {
                let id = snap as! DataSnapshot
               
                var referoom = Database.database().reference().child("rooms").child(id.value as! String)
            
    
        referoom.observe(DataEventType.value, with: {(snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let agend = value?["agenda"] as? String ?? ""
            let locat = value?["location"] as? String ?? ""
            let hashedKey = value?["hashedKey"] as? String ?? ""
            let start = value?["startingUnixTime"] as? String ?? ""
            let end = value?["endingUnixTime"] as? String ?? ""
            let meet = Meeting()
            meet.agenda = agend
            meet.location = locat
            meet.hashedKey = hashedKey
            meet.startingUnixTime = start
            meet.endingUnixTime = end
            meet.referroom = referoom
            self.meetArray.append(meet)
            self.configureTableView()
            self.meetingsTableView.reloadData()
        }){ (error) in
            print(error.localizedDescription)
        }
            }
        })
    }
 
    func configureTableView()
    {
        meetingsTableView.rowHeight = UITableView.automaticDimension
        meetingsTableView.estimatedRowHeight = 90
    }
    

   
    func createDateTime(timestamp: String) -> String {
        var strDate = "undefined"
            
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" //Specify your format that you want
            strDate = dateFormatter.string(from: date)
        }
            
        return strDate
    }
    
    @IBAction func makeRoomButtonPressed(_ sender: Any) {
    
        self.performSegue(withIdentifier: "goToRoomForm", sender: (Any).self)
}
}
