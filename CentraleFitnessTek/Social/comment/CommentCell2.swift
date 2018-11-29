//
//  CommentCell2.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 29/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class CommentCell2: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    var name: String = ""{
        didSet{
        nameLabel.text = name
        }
    }
    
    var comment: String = ""{
        didSet{
        commentLabel.text = comment
        }
    }
    
//    let timeStart = Double(challenges.start_date! / 1000)
//    let myNSDateStart = Date(timeIntervalSince1970: timeStart)
//
//    let formatter = DateFormatter()
//    //formatter.dateFormat = "dd-MM-yyyy"
//    formatter.dateFormat = "dd-MMM-yy HH:mm"
//    let myString = formatter.string(from: myNSDateStart)
//    let yourDate = formatter.date(from: myString)
//
//    if (yourDate != nil && yourDate2 != nil){
//    start.text = formatter.string(from: yourDate!)
//    end.text = formatter.string(from: yourDate2!)
//    print(start.text)
//    print(challenges.start_date)
    //}
    
    var date: Int = 0{
        didSet{
            let timeStart = Double(date / 1000)
            let myNSDateStart = Date(timeIntervalSince1970: timeStart)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MMM-yy HH:mm"
            let myString = formatter.string(from: myNSDateStart)
    
            let yourDate = formatter.date(from: myString)
            if (yourDate != nil){
                dateLabel.text = formatter.string(from: yourDate!)
            }
        }
    }
    
//    func setInfo(information: CommentInfo){
//        nameLabel.text = information.comment
//        commentLabel.text = information.name
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
