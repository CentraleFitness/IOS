//
//  ViewNewPassword.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 19/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Alamofire
import UIKit

class ViewNewPassword: UIViewController, UITextFieldDelegate{

    var token: String = ""
    @IBOutlet weak var _password1: UITextField!
    @IBOutlet weak var _password2: UITextField!
    @IBOutlet weak var _new_password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        _password1.delegate = self
        _password1.tag = 0
        _password2.delegate = self
        _password2.tag = 1
        _new_password.delegate = self
        _new_password.tag = 2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func press_new_password(_ sender: Any) {
        print("test registration:")
        
        if (_password1.text != _password2.text)
        {
            self.alert("Erreur", message: "Mot de passe non identique")
        }
       else
        {
            if (isPasswordValid(_password1.text!) == true)
            {
            let parameters: Parameters = [
                "token": self.token,
                "password": _password2.text!,
                "new_password": _new_password.text!
            ]
            
            Alamofire.request("http://163.5.84.201:8080/user/update/password", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
            else
            {
                     self.alert("Erreur", message: "Mot de passe non contient au moins 8 caratères, une majuscule et un caracère spécial")
            }
    }
    }    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */*/
   func alert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
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
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

}
