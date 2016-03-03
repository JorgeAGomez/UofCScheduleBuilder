//
//  OfferingTableViewCell.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2016-02-09.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit

class OfferingTableViewCell: UITableViewCell {

    @IBOutlet weak var offeringTime: UILabel!
    @IBOutlet weak var profRating: UILabel!
    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var offeringType: UILabel!
    
    var course: Course_new!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
