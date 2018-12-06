//
//  PopUpStat.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 01/12/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire

class PopUpStat: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var token: String
    var sessionId: String
    var time: Int
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getProduction()
        // Do any additional setup after loading the view.
    }
    
    init(token: String, sessionId: String, time: Int) {
        self.token = token
        self.sessionId = sessionId
        self.time = time
        super.init(nibName: "PopUpStat", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getProduction(){

            let parameters: Parameters = [
                "token": self.token,
                "session id": self.sessionId
            ]
            
            Alamofire.request("\(network.ipAdress.rawValue)/get/sportsessionstats", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    if let json = response.result.value as? [String: Any] {
                        let production = json["production"] as! [Double]
                        var total: Double = 0.0
                        var average: Double = 0.0
                        for (i, nb) in production.enumerated(){
                            total = total + nb
                        }
                        average = total / Double(production.count)
                        total = total * 100
                        total = Double(Int(total))
                        total = total / 100
                        average = average * 100
                        average = Double(Int(total))
                        average = average / 100
                        self.timeLabel.text = "  Durée: " + self.putTime(self.time)
                        self.totalLabel.text = "   Production Totale: "  + String(total)
                        self.averageLabel.text = "   Production Moyenne: " + String(average)
                    }
                    else{
                        print("Bad")
                    }
            }
    }
    
    func putTime(_ time: Int) -> String{
        var str: String = ""
        var heure: Int = 0
        var minutes: Int = 0
        var seconds: Int = time / 1000
        
        
        while (seconds > 60){
            seconds = seconds - 60
            minutes = minutes + 1
            if (minutes == 60){
                heure = heure + 1
                minutes = minutes - 60
            }
        }
        if (heure > 0){
            str = "\(heure) heures "
        }
        if (minutes > 0){
            str = str + "\(minutes) minutes "
        }
        str = str + "\(seconds) secondes"
        return str
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
