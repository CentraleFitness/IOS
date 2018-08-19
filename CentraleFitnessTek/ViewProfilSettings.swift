//
//  ViewProfilSettings.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 18/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class ViewProfilSettings: UIViewController {

    var token: String = ""
    //let storyboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    var firstViewController: ViewProfil = ViewProfil()
    //let firstController: ViewProfil
    @IBOutlet weak var button_change_image: UIButton!
    @IBOutlet weak var button_change_password: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("token profil settings")
        print(token)
        print("token profil settings")
        //firstViewController = ViewProfil()
       // firstViewController = storyboard?.instantiateViewController(withIdentifier: "ViewProfil") as! ViewProfil
        button_change_image.backgroundColor = .clear
        button_change_image.layer.cornerRadius = 10
        button_change_image.layer.borderColor = UIColor.black.cgColor
        
      //  button_change_password.backgroundColor = .clear
//        button_change_password.layer.cornerRadius = 10
  //  button_change_password.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func press_change_image(_ sender: Any) {
         firstViewController.importImage()
    }
    
    
    @IBAction func callFunctionInOtherClass(sender: AnyObject) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAlert"), object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
