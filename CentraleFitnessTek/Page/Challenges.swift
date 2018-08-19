//
//  Challenges.swift
//  test_tableview
//
//  Created by Fabien Santoni on 20/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit

class Challenges {
    var event_description: String
    var event_picture: UIImage
    var event_start_date: String
    var event_end_date: String
    var event_user_registered: Bool
    
  init(event_description: String, event_picture: String, event_start_date: String, event_end_date: String, event_user_registered: Bool)
    {
        self.event_description = event_description
        let dataDecoded : Data = Data(base64Encoded: event_picture, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        self.event_picture = decodedimage!
        self.event_start_date = event_start_date
        self.event_end_date = event_end_date
        self.event_user_registered = event_user_registered
        print("test")
        print(event_user_registered)
    }
//    init(event: Event) {
//        self.event_description = event.description!
//        self.event_picture = UIImage(named: "image_1 2")!
//        self.event_start_date = event.start_date!
//        self.event_end_date = event.end_date!
//        self.event_user_registered = false
//    }
}
