//
//  ProgramCell.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 15/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class ProgramCell: UITableViewCell {

    @IBOutlet weak var image_cell: UIImageView!
    @IBOutlet weak var note: UIImageView!
    @IBOutlet weak var name_cell: UILabel!
    @IBOutlet weak var duration_cell: UILabel!
    
    
    func setPrograms(program: ProgramEvent)
    {
        if (program.programDuration != nil){
            var seconde: Int = program.programDuration as! Int
            var minute: Int = 0
            
            while (seconde >= 60)
            {
                seconde = seconde - 60
                minute = minute + 1
            }
            print(program.programDuration as! Int)
            	duration_cell.text = String(minute) + " min " + String(seconde) + "s"
            
            //duration_cell.text = String(program.programDuration as Int!) + "secondes"
        }
        if (program.programPicture == nil){
            image_cell.image = UIImage(named: "image_1 2")
        }
        else{
            image_cell.image = self.base64Convert(base64String: program.programPicture)
        }
        if (program.programPicture == nil){
            image_cell.image = UIImage(named: "star_0")
        }
        else{
            if (program.programPicture != ""){
            image_cell.image = self.base64Convert(base64String: program.programPicture!)
            }
        }
         name_cell.text = program.programName
        if (program.programNote != nil)
        {
        if (Int(program.programNote!)! == 1){
            note.image = UIImage(named: "star_2")
        }
        else if (Int(program.programNote!)! == 2){
            note.image = UIImage(named: "star_4")
        }
        else if (Int(program.programNote!)! == 3){
            note.image = UIImage(named: "star_6")
        }
        else if (Int(program.programNote!)! == 4){
            note.image = UIImage(named: "star_8")
        }
        else if (Int(program.programNote!)! == 5){
            note.image = UIImage(named: "star_10")
        }
        else
        {
           note.image = UIImage(named: "star_0")
        }
        }
        /*if (program.favorites == true){
            favorites.backgroundColor = UIColor.green
        }
        else{
            favorites.backgroundColor = UIColor.orange
        }*/
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
