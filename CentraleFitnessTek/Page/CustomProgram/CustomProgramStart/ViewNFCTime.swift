//
//  ViewNFCTime.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 05/12/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire

class ViewNFCTime: UIViewController {
    
    @IBOutlet weak var gaugeView: BLGaugeView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var labelProduction: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    @IBOutlet weak var labelSeconds: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    
    var average: [Double] = []
    var total: Double = 0.0
    var stat: Int = 0
    var token: String = ""
    var seconds: Int
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelSeconds.text = String(seconds)
        runTimer()
        fetchProduction()
        self.gaugeView.setPercentValue(percentValue: 0)
        // Do any additional setup after loading the view.
    }
    
    init(seconds: Int) {
        self.seconds = seconds
        super.init(nibName: "ViewNFCTime", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func finishPressed(_ sender: Any) {
        timer.invalidate()
        self.pairStopNfc()
    }
    
    @IBAction func startPausePressed(_ sender: Any) {
        if (stat == 0){
            
            startButton.setTitle("PAUSE", for: .normal)
            stat = 1
        }
        else{
            startButton.setTitle("START", for: .normal)
            stat = 0
        }
    }
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewCustomProgramStart.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        fetchProduction()
        if (seconds > 0 && stat == 1) {
         seconds = seconds - 1
            labelSeconds.text = String(seconds)
        }
        if seconds < 1{
            timer.invalidate()
            let alertPopUp = UIAlertController(title: "Félicitation !", message:
                "Vous avez finit votre session", preferredStyle: UIAlertControllerStyle.alert)
            
            alertPopUp.addAction(UIAlertAction(title: "Terminer", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertPopUp, animated: true, completion: nil)
        }
    }
    @IBAction func LeavePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchProduction(){
        
        let parameters: Parameters = [ "token": token ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/user/get/instantproduction", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any?] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true"){
                    }
                    else{
                        if let json3 = json["production"] as? [Double] {
                            guard let firstElement = json3.first else {
                                print("Array empty")
                                return
                            }
                            self.gaugeView.setPercentValue(percentValue: CGFloat(firstElement.truncatingRemainder(dividingBy: 1)))
                            print(CGFloat(firstElement))
                            print("data production")
                            
                            self.total = self.total + firstElement
                            self.average.append(firstElement)
                            if (self.average.count > 100) {
                                self.average.dropLast()
                            }
                            let sumArray = self.average.reduce(0, +)
                            
                            let avgArrayValue = sumArray / Double(self.average.count)
                            self.labelAverage.text = "Moyenne: " + String(self.DoubleToKebab(double: avgArrayValue))
                            self.labelProduction.text = "Production: " + String(self.DoubleToKebab(double: firstElement))
                            self.labelTotal.text = "Total: " + String(self.DoubleToKebab(double: self.total))
                            print("data production")
                        }
                    }
                }
        }
    }
    
    func DoubleToKebab(double: Double) -> Double{
        var double2: Double = 0.0
        
        double2 = double
        double2 = double2 * 100
        double2 = Double(Int(double2))
        double2 = double2 / 100
        
        return double2
    }
    
    func pairStopNfc(){
        print("Appairage stop")
        let parameters: Parameters = [ "token": token]
        
        Alamofire.request("\(network.ipAdress.rawValue)/user/pair/stop", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let status = json["status"] as? String
                    print(error!)
                    if (error == "true"){
                    }
                    else{
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                else{
                    print("Bad")
                }
        }
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
