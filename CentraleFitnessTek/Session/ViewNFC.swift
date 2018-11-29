//
//  ViewNFC.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 29/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire

class ViewNFC: UIViewController {
    
    @IBOutlet weak var gaugeView: BLGaugeView!
    @IBOutlet weak var finishButton: UIButton!
    
    var token: String = ""
    var seconds = 1000
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        runTimer()
        let random = CGFloat(Double(arc4random())/Double(UInt32.max))
        self.gaugeView.setPercentValue(percentValue: random)
        // Do any additional setup after loading the view.
    }


    @IBAction func finishPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: (#selector(ViewCustomProgramStart.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        fetchProduction()
        //let random = CGFloat(Double(arc4random())/Double(UInt32.max))
        //self.gaugeView.setPercentValue(percentValue: random)
    }
    
    func fetchProduction(){
        
        let parameters: Parameters = [ "token": token ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/user/get/instantproduction", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true"){
                    }
                    else{
                        let json2 = json["production"]
                        
                        print(json2)
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
