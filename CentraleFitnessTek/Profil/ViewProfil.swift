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
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var token: String = ""
    var sportcenterid = ""
    
    let cellSpacingHeight: CGFloat = 5
    var list: [Information] = []
    var list_events: Array<Info> = []
    let bgColorView = UIView()
    var last_choice : Int = 0
    
    
    @IBOutlet var top_bar_view: UIImageView!
    @IBOutlet var page: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var button_settings: UIButton!
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
        getAfffiliation()
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
                                    self.myImageView.image = self.base64Convert(base64String: test)
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
            let dataDecoded : Data? = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)
            if (dataDecoded != nil){
                let decodedimage = UIImage(data: dataDecoded!)
                return decodedimage!
            }
            else{
                let decodedimage = UIImage(named: "icone_user_profil")
                return decodedimage!
            }
        }
    }
}

extension ViewProfil: UITableViewDelegate, UITableViewDataSource{
    
    func getAfffiliation()
    {
        let parameters: Parameters = [
            "token": self.token,
            ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/affiliation", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    self.sportcenterid = json["sport center id"] as! String
                    self.list = self.createArray()
                }
                else
                {
                    print("Bad")
                }
        }
    }
    
    func createArray() -> [Information] {
        var test: NSArray!
        print("Start Informations")
        
        var list_challenges: [Information] = []
        let parameters: Parameters = [
            "token": self.token,
            "target id": self.sportcenterid,
            "start": 0,
            "end": 100
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/posts", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let code = json["code"] as? String
                    if (error == "false")
                    {
                        
                        var json2 = json["posts"] as? [Dictionary<String, Any>]
                        self.list_events.removeAll()
                        self.list_events += Info.getEventArrayLittle(dict: json2!)
                        self.fill_event()
                    }
                }
                else
                {
                    print("Bad")
                }
        }
        return list_challenges
    }
    
    func fill_event()
    {
        var idx = 0
        
        while(idx < list_events.count)
        {
            getEventPreview(id: idx, event: list_events[idx]) { (event, idx) in
                self.list_events[idx].description = event.description
                self.tableView.reloadData()
            }
            idx = idx + 1
        }
        self.tableView.reloadData()
    }
    
    func getEventPreview(id: Int, event: Info, isSuccess: @escaping(_ event: Info,_ id: Int)-> Void){
        
        print("Start Events")
        
        let parameters: Parameters = [
            "token": self.token,
            "post id": event.infoId!
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/postcontent", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    isSuccess(Info.start_init_2(info: event, Dict: json), id)
                }
        }
    }
    
    @IBAction func anim1(_ sender: Any) {
        list = createArray()
        tableView.reloadData(
            with: .simple(duration: 0.75, direction: .rotation3D(type: .ironMan),
                          constantDelay: 0))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_events.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        last_choice = indexPath.row
//        let vc: ViewComment = ViewComment(token: token, postId: list_events[indexPath.item].infoId!)
//
//        self.present(vc, animated: true, completion: nil)
//    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //     let challenges = list[indexPath.row]
        let event = list_events[indexPath.item]
        let cell = Bundle.main.loadNibNamed("LittleSocialCell", owner: self, options: nil)?.first as! LittleSocialCell //tableView.dequeueReusableCell(withIdentifier: "challengesCell") as! ChallengesCell
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
        cell.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.setInfo(information: event)
        return cell
    }
    
}
