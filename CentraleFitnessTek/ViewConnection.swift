//
//  ViewConnection.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 09/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import RAMAnimatedTabBarController
import UIKit
import Foundation
import Alamofire


class ViewConnection: UIViewController, UITextFieldDelegate {
    
    var token: String!
    
    @IBOutlet var tfnombreentre: UITextField!
    @IBOutlet weak var blur_effect: UIVisualEffectView!
    @IBOutlet var button: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var label_stat: UILabel!
    @IBOutlet weak var _login: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet var _logo: UIImageView!
    var bgImage: UIImageView?
    var effect:UIVisualEffect!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blur_effect.isHidden = true
        effect = blur_effect.effect
        blur_effect.effect = nil
        
        print("test");
        _login.delegate = self
        _login.tag = 0
        _password.delegate = self
        _password.tag = 1
        // Transparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func goto(senter : UIButton)    {
        blur_effect.isHidden = false
        UIView.animate(withDuration: 0.4){
            self.blur_effect.effect = self.effect
        }
    }
    
    @IBAction func authentification(sender : UIButton)
    {
        print("test authentification:")
        var stat_account: Bool
        let parameters: Parameters = [
            "login": _login.text!,
            "password": _password.text!
        ]
        
        stat_account = false
        Alamofire.request("http://163.5.84.201:8080/authentication", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true")
                    {
                        self.alert("Mauvaise données..", message: "Votre mot de passe ou votre pseudo n'est pas bon..")
                        //let login = json["token"] as? String
                        //   print(login!)
                    }
                    else
                    {
                        self.token = json["token"] as? String
                        print(self.token)
                        self.get_affiliate(_token: self.token)
                    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       // let exo = storyboard.instantiateViewController(withIdentifier: "home") as! ViewRAM
                      //  exo.token = self.token;
                        //self.navigationController?.showDetailViewController(exo, sender: self)
                        //self.alert("Bravo !!", message: "Bravo !!")
                        // let login = json["token"] as? String
                        //  print(login!)
                    }
                }
                else
                {
                    print("Bad")
                }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if (segue.identifier == "profil")
     {
     let exo = segue.destination as! ViewProfil
     exo.token = self.token;
     }
     }*/
    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     _login.resignFirstResponder()
     _logo.resignFirstResponder()
     
     return true
     }*/
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.view.center = CGPoint(x:self.view.frame.size.width / 2, y:(self.view.frame.size.height / 2) - 90)
            self._logo.frame.size.width -= 100
            self._logo.frame.size.height -= 100
            self._logo.frame.origin.x += 50
            self._logo.frame.origin.y += 90
            self.button.frame.origin.y += 90
        }, completion: {
            (finished:Bool) in
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.view.center = CGPoint(x:self.view.frame.size.width / 2, y:(self.view.frame.size.height / 2))
            self._logo.frame.size.width += 100
            self._logo.frame.size.height += 100
            self._logo.frame.origin.x -= 50
            self._logo.frame.origin.y -= 90
            self.button.frame.origin.y -= 90
        }, completion: {
            (finished:Bool) in
        })
    }
    
    func get_affiliate(_token: String)
    {
        let parameters: Parameters = [
            "token": _token
        ]
        
        Alamofire.request("http://163.5.84.201:8080/get/affiliation", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true")
                    {
                        print("Utilisateur non inscrit")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let exo = storyboard.instantiateViewController(withIdentifier: "home_QR") as! ViewQRCode
                        exo.token = self.token;
                        self.navigationController?.showDetailViewController(exo, sender: self)
                    }
                    else
                    {
                        print("Utilisateur inscrit1")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let exo = storyboard.instantiateViewController(withIdentifier: "home") as! PageViewMenu
                        exo.token = self.token;
                        self.navigationController?.showDetailViewController(exo, sender: self)
                    }
                }
                else
                {
                    print("Bad")
                }
        }
    }
}

