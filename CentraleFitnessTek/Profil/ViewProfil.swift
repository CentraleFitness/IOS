//
//  ViewProfil.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 18/04/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

class ViewProfil: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var profil_image = UIImage(named: "Chat")
    @IBOutlet var top_bar_view: UIImageView!
    @IBOutlet var page: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var button_settings: UIButton!
    var token: String = ""
    var picture: String = ""//"data:image/png;base64,"
    @IBOutlet weak var _login: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(importImage), name: NSNotification.Name(rawValue: "showAlert"), object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableSwipe"), object: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        print("token profil")
        get_profil()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableSwipe"), object: nil)
    }
    
    @IBAction func push_button_settings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let exo = storyboard.instantiateViewController(withIdentifier: "viewProfilSettings") as! ViewProfilSettings
        exo.token = self.token;
        
        navigationController?.pushViewController(exo, animated: true)
    }
    
    @objc func importImage()
    {
        print("test")
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        myImageView?.layer.cornerRadius = myImageView.frame.size.width / 2
        myImageView?.clipsToBounds = true
        self.present(image, animated:true)
        {
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            myImageView.image = image

            let imageData: NSData = UIImagePNGRepresentation(myImageView.image!)! as NSData
            let imageStr = imageData.base64EncodedString(options:.endLineWithCarriageReturn)
            self.picture = imageStr
            //print(picture)
            send_picture_profile()
        }
        else
        {
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func press_button_1(_ sender: Any) {
        importImage()
    }
    
    func get_profil()
    {
        print("test profil:")
        let parameters: Parameters = [
            "token": self.token
        ]
        Alamofire.request("\(network.ipAdress.rawValue)/user/get/profile", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true")
                    {
                    }
                    else{
                        self._login.text = json["login"] as? String
                        self.get_picture_profile()
                    }
                }
                else{
                    print("Bad")
                }
        }
    }
    func get_picture_profile()
    {
        print("test picture profil:")
        let parameters: Parameters = [
            "token": self.token
        ]
        Alamofire.request("\(network.ipAdress.rawValue)/user/get/picture", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true")
                    {
                    }
                    else
                    {
                        if (json["picture"] == nil){
                            self.myImageView.image = UIImage(named: "image_1 2")
                        }
                        else{
                            if (json["picture"] as! String != ""){
                                var test2: String
                                let test: String
                                
                                test = json["picture"] as! String
                                test2 = "data:image/png;base64," + test
                                var chars = Array(test.characters)
                                if (chars[0] == "d" && chars[1] == "a" && chars[2] == "t" && chars[3] == "a")
                                {
                                    self.myImageView.image = self.base64Convert(base64String: test2)
                                }
                                else
                                {
                                     test2 = "data:image/png;base64," + test
                                     self.myImageView.image = self.base64Convert(base64String: test2)
                                }
                            }
                        }
                  //      self.myImageView.image = self.base64Convert(base64String: json["picture"] as? String)
                        self.myImageView?.layer.cornerRadius = self.myImageView.frame.size.width / 2
                        self.myImageView?.clipsToBounds = true
                    }
                }
                else
                {
                    print("Bad")
                }
                
        }
    }
    
    func send_picture_profile()
    {
        print("test send picture")
        let parameters: Parameters = [
            "token": self.token,
            "picture": self.picture
        ]
        Alamofire.request("\(network.ipAdress.rawValue)/user/update/picture", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true")
                    {
                    }
                    else{
                    print("image sending !")
                    }
                }
                else{
                    print("Bad")
                }
        }
    }
    
    func base64Convert(base64String: String?) -> UIImage{
        if (base64String?.isEmpty)! {
            print("Problème !!!!!!")
            let test: UIImage = UIImage(named: "image_1 2")!
            return (test)
        }
        else {
            print("On est là !!!!!!!!!")
            // !!! Separation part is optional, depends on your Base64String !!!
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
}
