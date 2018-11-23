//
//  ViewComment.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 23/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire

class ViewComment: UIViewController {
    
    @IBOutlet weak var button_refressh: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var postId: String = ""
    var token: String = ""
    var sportcenterid = ""
    
    let cellSpacingHeight: CGFloat = 5
    var list: [CommentInformation] = []
    var list_events: Array<CommentInfo> = []
    let bgColorView = UIView()
    var last_choice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgColorView.backgroundColor = UIColor.white
        getAfffiliation()
    }
    
    
    init(token: String, postId: String){
        self.token = token
        self.postId = postId
        
        super.init(nibName: "ViewComment", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getAfffiliation()
    {
        let parameters: Parameters = [
            "token": self.token,
            ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/affiliation", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    self.sportcenterid = json["sport center id"] as! String
                    print("sport center id")
                    print(self.sportcenterid)
                    self.list = self.createArray()
                }
                else
                {
                    print("Bad")
                }
        }
    }
    
    func createArray() -> [CommentInformation] {
        
        var list_challenges: [CommentInformation] = []
        let parameters: Parameters = [
            "token": self.token,
            "post id": self.postId,
            "start": 0,
            "range": 150
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/posts", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let code = json["code"] as? String
                    print(error!)
                    print(code!)
                    if (error == "false")
                    {
                        var json2 = json["comments"] as? [Dictionary<String, Any>]
                        self.list_events.removeAll()
                        self.list_events += CommentInfo.getEventArray(dict: json2!)
                        self.fill_event()
                        print()
                        
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
                self.list_events[idx] = event
               // self.tableView.reloadData()
            }
            idx = idx + 1
        }
        self.tableView.reloadData()
    }
    
    func getEventPreview(id: Int, event: CommentInfo, isSuccess: @escaping(_ event: CommentInfo,_ id: Int)-> Void){
        
        print("Start Events")
        
        let parameters: Parameters = [
            "token": self.token,
            "post id": event.infoId!
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/postcontent", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    isSuccess(CommentInfo.start_init_2(info: event, Dict: json), id)
                }
        }
    }
    
    @IBAction func postComment(_ sender: Any) {
        
        var list_challenges: [CommentInformation] = []
        let parameters: Parameters = [
            "token": self.token,
            "post id": self.postId,
            "comment content": ""
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/post-comment-create", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let code = json["code"] as? String
                    print(error!)
                    print(code!)
                    if (error == "false"){
                        self.tableView.reloadData()
                    }
                }
                else{
                    print("Bad")
                }
        }
    }
    @IBAction func anim1(_ sender: Any) {
        list = createArray()
        tableView.reloadData(
            with: .simple(duration: 0.75, direction: .rotation3D(type: .ironMan),
                          constantDelay: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension  ViewComment: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_events.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        last_choice = indexPath.row
        print(indexPath.row)
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //     let challenges = list[indexPath.row]
        let event = list_events[indexPath.item]
        let cell = Bundle.main.loadNibNamed("SocialCell", owner: self, options: nil)?.first as! SocialCell //tableView.dequeueReusableCell(withIdentifier: "challengesCell") as! ChallengesCell
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
        cell.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        //cell.setInfo(information: event)
        return cell
    }
}

