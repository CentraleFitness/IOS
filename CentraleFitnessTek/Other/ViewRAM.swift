//
//  ViewRAM.swift
//  Centrale_Fitness
//
//  Created by Fabien Santoni on 28/03/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import RAMAnimatedTabBarController
import UIKit
import Foundation
import Alamofire

class ViewRAM: RAMAnimatedTabBarController {
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("\ntoken :")
        print(token)

        //let storyboard = UIStoryboard(name: "Profil", bundle: nil)
        //let exo = storyboard.instantiateViewController(withIdentifier: "profil1") as! NavigationController2
        //exo.token = token;
        //self.navigationController?.showDetailViewController(exo, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "profil1")
        {
            
        }
    }
    
}
