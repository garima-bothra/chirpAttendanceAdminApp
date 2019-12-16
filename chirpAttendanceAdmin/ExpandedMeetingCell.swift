//
//  ExpandedMeetingCell.swift
//  chirpAttendanceAdmin
//
//  Created by Garima Bothra on 09/12/19.
//  Copyright © 2019 Garima Bothra. All rights reserved.
//

import UIKit

class ExpandedMeetingCell: UITableViewCell {

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var agenda: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
