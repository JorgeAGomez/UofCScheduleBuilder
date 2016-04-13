//
//  OfferingTableViewCell.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2016-02-09.
//  Copyright © 2016 Alexander "AI" Ivanov. All rights reserved.
//

import UIKit

class OfferingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var offeringTime: UILabel!
    @IBOutlet weak var profRating: UILabel!
    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var offeringType: UILabel!
    
    
    var type:   String! // lecture, tutorial, lab
    var lectureNum : Int!
    var num: Int! //for lecture it is section number, for lab and tutorial its num associated with each
    var active: Bool! //false -> greyed out
    var times: [Time]! // storing here for convenience
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
