//
//  Program.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 16/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit

class Program {
    var program_name: String
    var program_picture: UIImage
    var program_note: Int
    var program_duration: String
    var program_favorites: Bool
    
    init(program_name: String, event_picture : String, program_note: Int, program_duration: String, program_favorites: Bool)
    {
        self.program_name = program_name
        let dataDecoded : Data = Data(base64Encoded: event_picture, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.program_picture = decodedimage!
        self.program_note = program_note
        self.program_duration = program_duration
        self.program_favorites = program_favorites
    }
}
