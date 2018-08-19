//
//  ViewController.swift
//  Centrale_Fitness
//
//  Created by Fabien Santoni on 17/11/2017.
//  Copyright © 2017 Fabien Santoni. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewRegistration: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var _lastname: UITextField!
    @IBOutlet var _firstname: UITextField!
    @IBOutlet weak var _login: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _password2: UITextField!
    @IBOutlet weak var _addressmail: UITextField!
    @IBOutlet var _logo: UIImageView!
    @IBOutlet var _button_registration: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _login.delegate = self
        _login.tag = 0
        _addressmail.delegate = self
        _addressmail.tag = 1
        _password.delegate = self
        _password.tag = 2
        _password2.delegate = self
        _password2.tag = 3
        print("test");
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func registration(sender : UIButton)
    {
        print("test registration:")
        
        if (_password.text != _password2.text)
        {
            self.alert("Erreur", message: "Mot de passe non identique")
        }
        else
        {
        let parameters: Parameters = [
            "login": _login.text!,
            "password": _password.text!,
            "first name": "",
            "last name": "",
            "email address": _addressmail.text!,
            "phone number": "0624891343"
        ]
        
        Alamofire.request("http://127.0.0.1:8080/registration", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true")
                    {
                        self.alert("Mauvaise données..", message: "Ton mot de passe ou ton pseudo n'est pas bon, désolé..")
                        //let login = json["token"] as? String
                        //   print(login!)
                    }
                    else
                    {
                        self.alert("Bravo !!", message: "Bravo !!")
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
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.view.center = CGPoint(x:self.view.frame.size.width / 2, y:(self.view.frame.size.height / 2) - 90)
            self._logo.frame.size.width -= 30
            self._logo.frame.size.height -= 30
            self._logo.frame.origin.x += 15
            self._logo.frame.origin.y += 80
            self._button_registration.frame.origin.y += 90
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
            self._logo.frame.size.width += 30
            self._logo.frame.size.height += 30
            self._logo.frame.origin.x -= 15
            self._logo.frame.origin.y -= 80
            self._button_registration.frame.origin.y -= 90
        }, completion: {
            (finished:Bool) in
        })
    }
    
}


