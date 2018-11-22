//
//  SessionCell.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 01/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

struct SessionCellMediaModel{
    var stat: String!
    let logo: String!
    let name: String!
    var duration: Int!
    let needauth: Bool!
    
    init(logo: String, name: String, duration: Int, needauth: Bool) {
        self.stat = "Plus tard"
        self.logo = logo
        self.name = name
        self.duration = duration
        self.needauth = needauth
    }
}

class SessionCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    
    
    var viewModel: SessionCellMediaModel! {
        didSet{
            nameLabel.text = viewModel.name
            timeLabel.text = "temps: " + String(viewModel.duration)
            logoImage.image = base64Convert(base64String: viewModel.logo)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
    }
    
    func base64Convert(base64String: String?) -> UIImage{
        if (base64String?.isEmpty)! {
            let test: UIImage = UIImage(named: "image_1 2")!
            return (test)
        }
        else {
            // !!! Separation part is optional, depends on your Base64String !!!
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
}
