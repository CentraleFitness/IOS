//
//  CommentInformation.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 23/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit

class CommentInformation {
    var information_description: String
    var information_picture: UIImage
    
    init(information_description: String, information_picture: String)
    {
        self.information_description = information_description
        let dataDecoded : Data = Data(base64Encoded: information_picture, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.information_picture = decodedimage!
    }
}

