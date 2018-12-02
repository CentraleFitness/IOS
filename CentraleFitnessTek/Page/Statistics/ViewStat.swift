//
//  ViewStat.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 30/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire

struct sportAllData {
    
}


//struct SportSessions: Decodable {
//    let code: String
//    let sessionIds: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case code, sessionIds = "session id"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.code = try container.decode(String.self, forKey: .code)
//
//        let sessionIds = try container.decode([[String]].self, forKey: .sessionIds)
//
//        let flattenedSessions = sessionIds.map { $0[0] }
//        self.sessionIds = flattenedSessions
//    }
//}

class ViewStat: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var statCellModels: [StatCellModel] = []
    var token: String = ""
    var sportSessionId: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        getSportSessionId()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StatCell", bundle: nil), forCellReuseIdentifier: "StatCell")
        // Do any additional setup after loading the view.
    }
    
    func fill_event()
    {
        var idx = 0

        while(idx < statCellModels.count)
        {
            getEventPreview(id: idx, event: statCellModels[idx]) { (event, idx) in
                self.statCellModels[idx] = event
                self.tableView.reloadData()
            }
            idx = idx + 1
        }
    }
    
    func initModel(event: StatCellModel, json:[String: Any]) -> StatCellModel{
        event.date = json["date"] as? Int
        event.duration = json["duration"] as? Int
        event.type = json["type"] as? String
        
        return event
    }

    func getEventPreview(id: Int, event: StatCellModel, isSuccess: @escaping(_ event: StatCellModel,_ id: Int)-> Void){

        let parameters: Parameters = [
            "token": self.token,
            "session id": self.sportSessionId[id]
        ]

        Alamofire.request("\(network.ipAdress.rawValue)/get/sportsession", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    
                    isSuccess(self.initModel(event: event, json: json), id)
                    let error = json["error"] as? String
                    if error == "false"{
                       event.date = json["date"] as? Int
                        event.duration = json["duration"] as? Int
                        event.type = json["type"] as? String
                    }
                    else{
                        print(json["code"] as? String)
                    }
                }
        }
    }
    
    func getSportSessionId(){
        let parameters: Parameters = [
            "token": self.token,
            "start": 0,
            "end": 0
            ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/sportsessions", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                
//                guard let data = response.data else { return }
//
//                let sportSession = try? JSONDecoder().decode(SportSessions.self, from: data)
                if let json = response.result.value as? [String: Any] {
                    let json2 = json["session id"]
                    let json3: [[String]] = json2 as! [[String]]

                    //let array = json3.map { $0[0] }
                    for (idx, test) in json3.enumerated(){
                        self.sportSessionId.append(test[0])
                        self.statCellModels.append(StatCellModel())
                    }
                    print(self.sportSessionId)
                    self.fill_event()
                   // self.PickAllData()
                   // self.askMoreData()
                }
                else{
                    print("Bad")
                }
        }
    }
    
    func PickAllData(){
        var  index: Int = 0
        
        while (index != self.sportSessionId.count){
        let parameters: Parameters = [
            "token": self.token,
            "session id": self.sportSessionId[index]
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/sportsession", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let Statdate = json["date"]
                }
                else{
                    print("Bad")
                }
            }
            index = index + 1
        }
    }
    
    func askMoreData(){
        var  index: Int = 0
        while (index != self.sportSessionId.count){
        let parameters: Parameters = [
            "token": self.token,
            "session id": self.sportSessionId[index]
            ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/sportsessionstats", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let production = json["production"] as! [Double]
                    print(production)
                }
                else{
                    print("Bad")
                }
            }
            index = index + 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportSessionId.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcPopUp: PopUpStat = PopUpStat(token: self.token, sessionId: self.sportSessionId[indexPath.item], time: self.statCellModels[indexPath.item].duration!)
        vcPopUp.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vcPopUp, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatCell", for: indexPath) as! StatCell
        
        cell.date = statCellModels[indexPath.item].date
        cell.type = statCellModels[indexPath.item].type
        cell.duration = statCellModels[indexPath.item].duration
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
