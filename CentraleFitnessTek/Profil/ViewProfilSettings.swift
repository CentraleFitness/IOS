//
//  ViewProfilSettings.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 18/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire
import PopupDialog

class ViewProfilSettings: UIViewController {

    var token: String = ""
    //let storyboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    var firstViewController: ViewProfil = ViewProfil()
    //let firstController: ViewProfil
    @IBOutlet weak var button_change_image: UIButton!
    @IBOutlet weak var button_change_password: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableSwipe"), object: nil)
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
    
    func showStandardDialogChangeSalle(animated: Bool = true) {
        
        // Prepare the popup
        let title = "Etes vous sûre de vouloir changer de salle ?"
        let message = ""
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true,
                                hideStatusBar: true) {
                                    print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "Annuler") {
            // self.label.text = "You canceled the default dialog"
        }
        
        // Create second button
        var text: String = ""
        
        text = "Oui !"
        
        let buttonTwo: PopupDialogButton =
        DefaultButton(title: "Oui !") {
            setEntity(_token: "", _centerId: "")
            self.unaffiliate()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let exo = storyboard.instantiateViewController(withIdentifier: "navigationConnection") as! UINavigationController
            self.present(exo, animated: true, completion: nil)
        }
        
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    func showStandardDialogDisco(animated: Bool = true) {
        
        // Prepare the popup
        let title = "Etes vous sûre de vouloir vous déconnecter ?"
        let message = ""
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true,
                                hideStatusBar: true) {
                                    print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "Annuler") {
            // self.label.text = "You canceled the default dialog"
        }
        
        // Create second button
        var text: String = ""
        
        text = "Oui !"
        
        let buttonTwo: PopupDialogButton =
        DefaultButton(title: "Oui !") {
            setEntity(_token: "", _centerId: "")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let exo = storyboard.instantiateViewController(withIdentifier: "navigationConnection") as! UINavigationController
            self.present(exo, animated: true, completion: nil)
        }

        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    @IBAction func pressDisconnect(_ sender: Any) {
        showStandardDialogDisco(animated: true)
    }
    
    @IBAction func pressChangeRoom(_ sender: Any) {
        showStandardDialogChangeSalle()
    }
    
    func unaffiliate()
    {
        print("unfiliate")
        let parameters: Parameters = [
            "token": self.token
        ]
        Alamofire.request("\(network.ipAdress.rawValue)/unaffiliate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true"){
                    }
                    else{
                        print("tu es desafillier !")
                    }
                }
                else{
                    print("Bad")
                }
        }
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
