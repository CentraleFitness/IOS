//
//  CommentCell.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 23/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func setInfo(information: Info)
    {
//        if (information.picture == nil){
//            image_cell.image = UIImage(named: "image_1 2")
//        }
//        else{
//            image_cell.image = self.base64Convert(base64String: information.picture)
//        }
//        if (information.infoName == "EVENT")
//        {
//            title_cell.text = "Un nouvel évènement !"
//            image_cell.image = UIImage(named: "SocialEvent")
//        }
//        else
//        {
//            title_cell.text = "Un message de votre salle !"
//            image_cell.image = UIImage(named: "SocialMessage")
//        }
//        description_cell.text = information.description
//        
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
