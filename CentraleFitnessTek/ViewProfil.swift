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
    var picture: String = "data:image/png;base64,"
    @IBOutlet weak var _login: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(importImage), name: NSNotification.Name(rawValue: "showAlert"), object: nil)
        
        //myImageView.image = "icone_user_profil"
        //myImageView.image = UIImage(named:#imageLiteral(resourceName: "icone_user_profil"))
        //myImageView = UIImageView(image: profil_image)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
      //  let color = UIColor(named: "color_red")
//        let shadowPath = UIBezierPath(rect: view.bounds)

     /*   top_bar_view.layer.masksToBounds = false
        top_bar_view.layer.shadowColor = color?.cgColor
        top_bar_view.layer.shadowOffset = CGSize(width: 2, height: 4)
        top_bar_view.layer.shadowOpacity = 0.3
        top_bar_view.layer.shadowPath = shadowPath.cgPath
        page.layer.masksToBounds = false
        page.layer.shadowColor = color?.cgColor
        page.layer.shadowOffset = CGSize(width: 2, height: 4)
        page.layer.shadowOpacity = 0.3
        page.layer.shadowPath = shadowPath.cgPath*/
        // Do any additional setup after loading the view, typically from a nib.
        //get_profil()
  
        print("token profil")
        print(token)
        print("token profil")
        get_profil()
        
    }
    
  /*  @objc func getToken(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getToken"), object: String())
    }*/
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
            //Now use image to create into NSData format
            let imageData:NSData = UIImagePNGRepresentation(myImageView.image!)! as NSData
            picture = picture + imageData.base64EncodedString()
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
        Alamofire.request("http://163.5.84.201:8080/user/get/profile", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
        Alamofire.request("http://163.5.84.201:8080/user/get/picture", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true")
                    {
                    }
                    else
                    {
                        self.myImageView.image = self.base64Convert(base64String: json["picture"] as? String)
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
        Alamofire.request("http://163.5.84.201:8080/user/update/picture", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
            return #imageLiteral(resourceName: "no_image_found")
        }else {
            // !!! Separation part is optional, depends on your Base64String !!!
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
}
