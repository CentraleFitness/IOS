//
//  ViewSocial.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 18/04/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

class ViewSocial: UIViewController {
    
    @IBOutlet weak var button_refressh: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var token: String = ""
    var sportcenterid = ""
    
    let cellSpacingHeight: CGFloat = 5
    var list: [Information] = []
    var list_events: Array<Info> = []
    let bgColorView = UIView()
    var last_choice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgColorView.backgroundColor = UIColor.white
        getAfffiliation()
        //list = createArray()
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
                    print(error!)
                    print(code!)
                    if (error == "false")
                    {
                        
                       var json2 = json["posts"] as? [Dictionary<String, Any>]
                        self.list_events.removeAll()
                        self.list_events += Info.getEventArray(dict: json2!)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension  ViewSocial: UITableViewDataSource, UITableViewDelegate {
    
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
        cell.setInfo(information: event)
        return cell
    }
}

