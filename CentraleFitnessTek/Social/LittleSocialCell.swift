//
//  LittleSocialCell.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 02/12/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class LittleSocialCell: UITableViewCell {
    
    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var description_cell: UILabel!
    @IBOutlet weak var title_cell: UILabel!
    @IBOutlet weak var button_strong: UIButton!
    @IBOutlet weak var button_like: UIButton!
    
    func setInfo(information: Info)
    {
        if (information.picture == nil){
            image_cell.image = UIImage(named: "image_1 2")
        }
        else{
            image_cell.image = self.base64Convert(base64String: information.picture)
        }
        if (information.infoName == "PUBLICATION")
        {
            if (information.infoPostIcon != nil){
                image_cell.image = base64Convert(base64String: information.infoPostIcon)
                self.image_cell.layer.cornerRadius = self.image_cell.frame.size.width / 2
                
                self.image_cell.clipsToBounds = true
            }
            title_cell.text = information.infoName2
        }
        else
        {
            title_cell.text = ""
        }
        description_cell.text = information.description
        
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
    
    @IBAction func pulseButtonStrong(_ sender: UIButton) {
        sender.pulsate()
    }
    @IBAction func pulseButtonLike(_ sender: UIButton) {
        sender.pulsate()
    }
}
