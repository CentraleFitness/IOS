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

    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var date: Int? = 0{
        didSet{
            let timeStart = Double(date! / 1000)
            let myNSDateStart = Date(timeIntervalSince1970: timeStart)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yy HH:mm"
            let myString = formatter.string(from: myNSDateStart)
            
            let yourDate = formatter.date(from: myString)
            if (yourDate != nil){
                timeLabel.text = formatter.string(from: yourDate!)
            }
        }
        
    }
    var duration: Int? = 0{
        didSet{
            durationLabel.text = putTime(duration!)
        }
    }
    var type: String? = ""{
        didSet{
            //typeLabel.text = type
            typeImage.image = UIImage(named: "elliptique-icon")
        }
    }
    
    func putTime(_ time: Int) -> String{
        var str: String = ""
        var days: Int = 0
        var hours: Int = 0
        var minutes: Int = time
        
        while (minutes > 60){
            minutes = minutes - 60
            hours = hours + 1
            if (hours == 24){
                days = days + 1
                hours = hours - 24
            }
        }
        if (days > 0){
            str = "\(days) jours "
        }
        if (hours > 0){
            str = str + "\(hours) heures "
        }
        str = str + "\(minutes) minutes"
        return str
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
