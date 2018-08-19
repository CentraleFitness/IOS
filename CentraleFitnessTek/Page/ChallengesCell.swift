//
//  TableViewChallenges.swift
//  test_tableview
//
//  Created by Fabien Santoni on 20/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class ChallengesCell: UITableViewCell {

    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var description_cell: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var registered: UIView!
    
    
    func setChallenges(challenges: Event)
    {
        if (challenges.picture == nil)
        {
            image_cell.image = UIImage(named: "image_1 2")
        }
        else
        {
            //let dataDecoded : Data = Data(base64Encoded: challenges.picture! , options: .ignoreUnknownCharacters)!
            //let decodedimage = UIImage(data: dataDecoded)
            image_cell.image = self.base64Convert(base64String: challenges.picture!)
           // image_cell.image = decodedimage
        }
        description_cell.text = challenges.description
        
        if (challenges.start_date != nil && challenges.end_date != nil)
        {
        let timeStart = Double(challenges.start_date!)
        let myNSDateStart = Date(timeIntervalSince1970: timeStart)
        let timeEnd = Double(challenges.end_date!)
        let myNSDateEnd = Date(timeIntervalSince1970: timeEnd)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            //formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
            let myString = formatter.string(from: myNSDateStart)
            let yourDate = formatter.date(from: myString)
            //formatter.dateFormat = "dd-MMM-yyyy"
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "dd-MM-yyyy"
            //formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
            let myString2 = formatter.string(from: myNSDateEnd)
            let yourDate2 = formatter.date(from: myString2)
        
        start.text = formatter.string(from: yourDate!)
        end.text = formatter.string(from: yourDate2!)
        }
        if (challenges.user_registered == true){
          registered.backgroundColor = UIColor.blue
        }
        else{
            registered.backgroundColor = UIColor.orange
        }
    }
    
    func base64Convert(base64String: String?) -> UIImage{
        if (base64String?.isEmpty)! {
            return #imageLiteral(resourceName: "no_image_found")
        }else {
            // !!! Separation part is optional, depends on your Base64String !!!
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
}
