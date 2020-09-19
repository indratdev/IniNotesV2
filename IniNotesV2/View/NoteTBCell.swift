//
//  NoteTBCell.swift
//  IniNotesV2
//
//  Created by IndratS on 19/09/20.
//  Copyright © 2020 IndratSaputra. All rights reserved.
//

import UIKit

class NoteTBCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addDateLabel: UILabel!
    @IBOutlet weak var decsriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
