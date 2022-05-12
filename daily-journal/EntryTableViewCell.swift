//
//  EntryTableViewCell.swift
//  daily-journal
//
//  Created by Patricia Jamriskova on 11.05.2022.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var entryTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
