//
//  AttendeeTableViewCell.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 08/12/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit

class AttendeeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMail: UILabel!
    @IBOutlet weak var user_id: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
