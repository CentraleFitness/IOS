//
//  SocialCell.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 17/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class SocialCell: UITableViewCell {
    
    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var description_cell: UILabel!
    @IBOutlet weak var title_cell: UILabel!
    @IBOutlet weak var button_like: UIButton!
    @IBOutlet weak var labeLikes: UILabel!
    
    weak var delegate: ViewSocialDelegate? = nil
    
    var isLike: Bool = false
    var postId: String = ""
    
    func setInfo(information: Info)
    {
        self.isLike = information.infoIsLike!
        if (information.infoIsLike == false){
            button_like.imageView?.image = UIImage(named: "like_heart_off")
        }
        else{
            button_like.imageView?.image = UIImage(named: "like_heart")
        }
        labeLikes.text = "\(information.infoLikes!) likes"
        if (information.picture == nil){
            image_cell.image = UIImage(named: "image_1 2")
        }
        else{
            image_cell.image = base64Convert(base64String: information.picture)
        }
        if (information.infoName == "EVENT")
        {
            title_cell.text = information.infoName2
            description_cell.text = information.description
            if (information.infoPostPicture != nil){
              image_cell.image = base64Convert(base64String: information.infoPostPicture)
            }
            //image_cell.image = base64Convert(base64String: information.infoPostPicture)
            //image_cell.image = UIImage(named: "SocialEvent")
        }
        else if (information.infoName == "PUBLICATION")
        {
            title_cell.text = information.infoName2
            description_cell.text = information.description
            if (information.infoPostIcon != nil){
                image_cell.image = base64Convert(base64String: information.infoPostIcon)
            }
            self.image_cell.layer.cornerRadius = self.image_cell.frame.size.width / 2
            
            self.image_cell.clipsToBounds = true
            //image_cell.image = UIImage(named: "SocialMessage")
        }
        else{
            title_cell.text = information.infoName2
            description_cell.text = information.description
            if (information.infoPostPicture != nil){
                image_cell.image = base64Convert(base64String: information.infoPostPicture)
            }
        }
    }
    func base64Convert(base64String: String?) -> UIImage{
        if ((base64String?.isEmpty)!) {
            return UIImage(named: "SocialMessage")!
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
        delegate?.sendLike(postId: postId)
        if (self.isLike == true){
            self.isLike = false
            button_like.setImage(UIImage(named: "like_heart_off"), for: .normal)
        }
        else{
            self.isLike = true
            button_like.setImage(UIImage(named: "like_heart"), for: .normal)
        }
    }
}
