//
//  meeting.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 07/12/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//
import Firebase
class Meeting
{
    var agenda : String = ""
    var hashedKey : String = ""
    var location : String = ""
    var startingUnixTime : String = ""
    var endingUnixTime : String = ""
    var referroom : DatabaseReference = Database.database().reference()
    var attendees = [ String : String]()
}
