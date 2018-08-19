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
    
    func setChallenges(challenges: Challenges)
    {
        image_cell.image = challenges.event_picture
        description_cell.text = challenges.event_description
        start.text = challenges.event_start_date
        end.text = challenges.event_end_date
        if (challenges.event_user_registered == true){
          
        }
        else{
          
        }
    }
}
