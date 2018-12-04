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
    @IBOutlet weak var labelProduction: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    
    var token: String = ""
    var seconds = 1000
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        runTimer()
        fetchProduction()
        //let random = CGFloat(Double(arc4random())/Double(UInt32.max))
        self.gaugeView.setPercentValue(percentValue: 0)
        // Do any additional setup after loading the view.
    }


    @IBAction func finishPressed(_ sender: Any) {
        timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewCustomProgramStart.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        fetchProduction()
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
                            //var c = NSDecimalNumber(json3![0] as NSNumber)
                           // let json2 = json3 as! [String]
                            //print(c)
//                            if json2 != nil{
//                            if json2.count > 0{
//                            self.self.gaugeView.setPercentValue(percentValue: CGFloat(json2[0]))
//                            let sumArray = json2.reduce(0, +)
//                            self.labelProduction.text = "Production : " + String(json2[0])
                            print("data production")
                                //}
                                
//                            }
//                        }
//                        else{
//                            print("No data production")
                        }
                    }
//                }
//                else{
//                    print("Bad")
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
