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
        var heure: Int = 0
        var minutes: Int = 0
        var seconds: Int = time / 1000
        
        while (seconds > 60){
            seconds = seconds - 60
            minutes = minutes + 1
            if (minutes == 60){
                heure = heure + 1
                minutes = minutes - 60
            }
        }
        if (heure > 0){
            str = "\(heure) heures "
        }
        if (minutes > 0){
            str = str + "\(minutes) minutes "
        }
        str = str + "\(seconds) secondes"
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
