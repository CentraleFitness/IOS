//
//  ViewDefi.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 29/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire

class ViewDefi: UIViewController {

    @IBOutlet weak var currentPicture: UIImageView!
    @IBOutlet weak var wattsTotalLabel: UILabel!
    @IBOutlet weak var timeTotalLabel: UILabel!
    @IBOutlet weak var textChangeLabel: UILabel!
    
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var tvButton: UIButton!
    @IBOutlet weak var playstationButton: UIButton!
    @IBOutlet weak var washButton: UIButton!
    
    var position: Int = 1
    var token: String = ""
    var prodution: Double = 0
    var ampoulePerHour = 40;
    var tvLEDPerHour = 90;
    var consolePerHour = 137;
    var machineALaverPerHour = 1000;
    
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        runTimer()
        currentPicture.image = UIImage(named: "button-light-no")
        lightButton.setImage(UIImage(named: "button-light-yes"), for: .normal)
        getTotalEnergy()
        // Do any additional setup after loading the view.
    }
    
    func putTime(_ time: Int) -> String{
        var str: String = ""
        var heure: Int = 0
        var minutes: Int = 0
        var seconds: Int = time
        
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
    
    func applyPosition(position: Int){
        wattsTotalLabel.text = "\(Int(prodution)) Watts !!"
        
        if position == 1{
            let time = 60 * Int(prodution) / ampoulePerHour
            timeTotalLabel.text = putTime(time)
            textChangeLabel.text = "Ce qui vous permet de faire fonctionner une ampoule durant"
        }
        else if (position == 2){
            let time = 60 * Int(prodution) / tvLEDPerHour
            timeTotalLabel.text = putTime(time)
            textChangeLabel.text = "Ce qui vous permet de faire fonctionner une télé durant"
        }
        else if (position == 3){
            let time = 60 * Int(prodution) / consolePerHour
            timeTotalLabel.text = putTime(time)
            textChangeLabel.text = "Ce qui vous permet de faire fonctionner une console durant"
        }
        else if (position == 4){
            let time = 60 * Int(prodution) / machineALaverPerHour
            timeTotalLabel.text = putTime(time)
            textChangeLabel.text = "Ce qui vous permet de faire fonctionner un lave linge durant"
        }
    }
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: (#selector(ViewCustomProgramStart.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        
        getTotalEnergy()
    }
    
    func getTotalEnergy() {
        let parameters: Parameters = [
            "token": self.token
            ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/user/get/totalproduction", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let code = json["code"] as? String
                    print(error!)
                    print(code!)
                    if (error == "false"){
                    self.prodution = json["production"] as! Double
                    print(self.prodution)
                    self.applyPosition(position: self.position)
                    }
                    else{
                        print("Bad")
                    }
                }
        }
    }

    @IBAction func lightPressed(_ sender: Any) {
        currentPicture.image = UIImage(named: "button-light-no")
        lightButton.setImage(UIImage(named: "button-light-yes"), for: .normal)
        tvButton.setImage(UIImage(named: "button-tv-no"), for: .normal)
        playstationButton.setImage(UIImage(named: "button-playstation-no"), for: .normal)
        washButton.setImage(UIImage(named: "button-wash-no"), for: .normal)
        position = 1
        getTotalEnergy()
    }
    
    
    @IBAction func tvPressed(_ sender: Any) {
        currentPicture.image = UIImage(named: "button-tv-no")
        lightButton.setImage(UIImage(named: "button-light-no"), for: .normal)
        tvButton.setImage(UIImage(named: "button-tv-yes"), for: .normal)
        playstationButton.setImage(UIImage(named: "button-playstation-no"), for: .normal)
        washButton.setImage(UIImage(named: "button-wash-no"), for: .normal)
        position = 2
        getTotalEnergy()
    }
    
    
    @IBAction func playstationPressed(_ sender: Any) {
        currentPicture.image = UIImage(named: "button-playstation-no")
        lightButton.setImage(UIImage(named: "button-light-no"), for: .normal)
        tvButton.setImage(UIImage(named: "button-tv-no"), for: .normal)
        playstationButton.setImage(UIImage(named: "button-playstation-yes"), for: .normal)
        washButton.setImage(UIImage(named: "button-wash-no"), for: .normal)
        position = 3
        getTotalEnergy()
    }
    
    
    @IBAction func washPressed(_ sender: Any) {
        currentPicture.image = UIImage(named: "button-wash-no")
        lightButton.setImage(UIImage(named: "button-light-no"), for: .normal)
        tvButton.setImage(UIImage(named: "button-tv-no"), for: .normal)
        playstationButton.setImage(UIImage(named: "button-playstation-no"), for: .normal)
        washButton.setImage(UIImage(named: "button-wash-yes"), for: .normal)
        position = 4
        getTotalEnergy()
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
