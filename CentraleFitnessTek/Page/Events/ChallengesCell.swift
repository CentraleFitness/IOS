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
        if (challenges.picture == nil){
            image_cell.image = UIImage(named: "image_1 2")
        }
        else{
            if (challenges.picture != ""){
                image_cell.image = self.base64Convert(base64String: challenges.picture!)
            }
        }
        description_cell.text = challenges.description
        
        if (challenges.start_date != nil && challenges.end_date != nil)
        {
        let timeStart = Double(challenges.start_date! / 1000)
        let myNSDateStart = Date(timeIntervalSince1970: timeStart)
        let timeEnd = Double(challenges.end_date! / 1000)
        let myNSDateEnd = Date(timeIntervalSince1970: timeEnd)
            
            let formatter = DateFormatter()
            //formatter.dateFormat = "dd-MM-yyyy"
            formatter.dateFormat = "dd-MMM-yy HH:mm"
            let myString = formatter.string(from: myNSDateStart)
            let yourDate = formatter.date(from: myString)
            //formatter.dateFormat = "dd-MMM-yyyy"
            let formatter2 = DateFormatter()
            //formatter2.dateFormat = "dd-MM-yyyy"
            formatter2.dateFormat = "dd-MMM-yy HH:mm"
            let myString2 = formatter.string(from: myNSDateEnd)
            let yourDate2 = formatter.date(from: myString2)
        
            print("\n\ntestbool")
            if (yourDate != nil && yourDate2 != nil){
                start.text = formatter.string(from: yourDate!)
                end.text = formatter.string(from: yourDate2!)
                print(start.text)
                print(challenges.start_date)
            }
        }
        if (challenges.user_registered == true){
          registered.backgroundColor = UIColor.green
        }
        else{
            registered.backgroundColor = UIColor.orange
        }
    }
    
    public func base64Convert(base64String: String?) -> UIImage?{
        if (base64String?.isEmpty)! {
            print("Problème !!!!!!")
            let test: UIImage = UIImage(named: "image_1 2")!
            return (test)
        }else {
            print("On est là !!!!!!!!!")
            // !!! Separation part is optional, depends on your Base64String !!!
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            if (decodedimage != nil){
                return decodedimage!
            }
            else{
                return nil
            }
        }
    }
}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    
    public func base64(format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImagePNGRepresentation(self)
        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(self, compression)
        }
        return imageData?.base64EncodedString()
    }
}
