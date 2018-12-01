//
//  StatCell.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 30/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class StatCellModel {
    var date: Int? = 0
    var production: [Int]? = []
    var duration: Int? = 0
    var type: String? = ""
}

class StatCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var date: Int? = 0{
        didSet{
            timeLabel.text =  String(date as! Int)
        }
        
    }
    var duration: Int? = 0{
        didSet{
            durationLabel.text = String(duration as! Int)
        }
    }
    var type: String? = ""{
        didSet{
            typeLabel.text = type
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
