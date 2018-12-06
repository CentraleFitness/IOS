//
//  ViewCustomProgram.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 19/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import PopupDialog
import Alamofire
import UIKit

class ViewCustomProgram: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button_refresh: UIButton!
    var token: String = ""
    
    var favorites: Bool = false
    let cellSpacingHeight: CGFloat = 5
    var list: [Program] = []
    var list_events: Array<ProgramEvent> = []
    let bgColorView = UIView()
    var last_choice : Int = 0
    var sportcenterid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("token Program")
        print(token)
        print("token Program")
        bgColorView.backgroundColor = UIColor.white
        //list = createArray()
        getAffiliation()
        // Do any additional setup after loading the view, typically from a nib.
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
                    print("sport center id")
                    print(self.sportcenterid)
                    self.list = self.createArray_2()
                }
                else{
                    print("Bad")
                }
        }
    }
    
    func createArray() -> [Program] {
        var list_challenges: [Program] = []
        
        /*    let challenge_1 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: true)
         let challenge_2 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 2"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: false)
         let challenge_3 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 3"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: true)
         let challenge_4 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 4"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: true)
         let challenge_5 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 5"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: false)
         let challenge_6 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 6"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: false)
         let challenge_7 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 7"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: false)
         
         list_challenges.append(challenge_1)
         list_challenges.append(challenge_2)
         list_challenges.append(challenge_3)
         list_challenges.append(challenge_4)
         list_challenges.append(challenge_5)
         list_challenges.append(challenge_6)
         list_challenges.append(challenge_7)*/
        
        return list_challenges
    }
    
    func createArray_2() -> [Program] {
        var test: NSArray!
        print("Start EventsProgram")
        
        var list_challenges: [Program] = []
        let parameters: Parameters = [
            "token": self.token,
            "sport center id": self.sportcenterid,
            "start": 0,
            "end": 100
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/customProgram-get-range", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let code = json["code"] as? String
                    print(error!)
                    print(code!)
                    if (error == "false")
                    {
                        let json2 = json["custom programs"] as? [Dictionary<String, Any>]
                        print(json2)
                        self.list_events.removeAll()
                        self.list_events += ProgramEvent.getEventArray(dict: json2!)
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
                self.tableView.reloadData()
            }
            idx = idx + 1
        }
    }
    
    func getEventPreview(id: Int, event: ProgramEvent, isSuccess: @escaping(_ event: ProgramEvent,_ id: Int)-> Void){
        
        print("Start Events")
        
        let parameters: Parameters = [
            "token": self.token,
            "custom program id": event.programtId
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/customProgram-get-preview", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    print("fafafafa")
                    isSuccess(ProgramEvent.start_init_2(event: event, Dict: json), id)
                }
        }
    }
    
    @IBAction func anim1(_ sender: Any) {
        list = createArray_2()
        tableView.reloadData(
            with: .simple(duration: 0.75, direction: .rotation3D(type: .ironMan),
                          constantDelay: 0))
    }
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        print("go to segment")
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            self.favorites = false
        case 1:
            self.favorites = true
        default:
            break
        }
        print("go to segment2")
        print(self.favorites)
        list = createArray_2()
        tableView.reloadData(
            with: .simple(duration: 1, direction: .rotation3D(type: .ironMan),
                          constantDelay: 0))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension  ViewCustomProgram: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_events.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myViewController = PopUpCustomProgram(name: list_events[indexPath.item].programName!, token: token, programId: list_events[indexPath.item].programtId!)
        myViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(myViewController, animated: true, completion: nil)
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
        let cell = Bundle.main.loadNibNamed("ProgramCell", owner: self, options: nil)?.first as! ProgramCell //tableView.dequeueReusableCell(withIdentifier: "challengesCell") as! ChallengesCell
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
        cell.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.setPrograms(program: event)
        return cell
    }
    

    
}





