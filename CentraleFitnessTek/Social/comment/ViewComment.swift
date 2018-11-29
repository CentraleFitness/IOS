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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textViewPost: UITextView!
    @IBOutlet weak var postButton: UIButton!
    var postId: String = ""
    var token: String = ""
    var sportcenterid = ""
    static let cellIdentifier: String = String(describing: CommentCell2.self)
    
    let cellSpacingHeight: CGFloat = 5
    var list: [CommentInformation] = []
    var list_events: Array<CommentInfo> = []
    let bgColorView = UIView()
    var last_choice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CommentCell2", bundle: nil), forCellReuseIdentifier: ViewComment.cellIdentifier)
        bgColorView.backgroundColor = UIColor.white
        getAffiliation()
    }
    
    
    init(token: String, postId: String){
        self.token = token
        self.postId = postId
        
        super.init(nibName: "ViewComment", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getAffiliation()
    {
        let parameters: Parameters = [
            "token": self.token,
            ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/affiliation", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    self.sportcenterid = json["sport center id"] as! String
                    self.createArray()
                }
                else
                {
                    print("Bad")
                }
        }
    }
    
    func createArray(){
        let parameters: Parameters = [
            "token": self.token,
            "post id": self.postId,
            "start": 0,
            "end": 150
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/post-comment-get-range", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let code = json["code"] as? String
                    print(error!)
                    print(code!)
                    if (error == "false")
                    {
                        let json2 = json["comments"] as? [Dictionary<String, Any>]
                        print(json2!.count)
                        self.list_events.removeAll()
                        self.list_events = CommentInfo.getEventArray(dict: json2!)
                        self.tableView.reloadData()
                    //    self.fill_event()
                    }
                }
                else{
                    print("Bad")
                }
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func postComment(_ sender: Any) {
        
        var list_challenges: [CommentInformation] = []
        let parameters: Parameters = [
            "token": self.token,
            "post id": self.postId,
            "comment content": textViewPost.text
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/post-comment-create", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let code = json["code"] as? String
                    print(error!)
                    print(code!)
                    if (error == "false"){
                        self.textViewPost.text = ""
                        self.view.endEditing(true)
                        self.createArray()
                        self.tableView.reloadData()
                    }
                }
                else{
                    print("Bad")
                }
        }
    }
    @IBAction func anim1(_ sender: Any) {
        createArray()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell2", for: indexPath) as! CommentCell2
        cell.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        let commentInfo: CommentInfo = list_events[indexPath.item]
        cell.name = commentInfo.name!
        cell.comment = commentInfo.comment!
        cell.date = commentInfo.date!
        return cell
    }
}

