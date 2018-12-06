//
//  ViewCustomProgramStart.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 19/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire
import CoreNFC

class ViewCustomProgramStart: UIViewController, UITableViewDelegate, UITableViewDataSource, NFCNDEFReaderSessionDelegate{
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var apperageButton: UIButton!
    
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?
    
    var token: String = ""
    var indexSteps: Int = 0
    var seconds = 0
    var timer: Timer
    var isTimerRunning = false
    var resumeTapped = false
    
    var steps: [SessionCellMediaModel]
    
    init(steps: [SessionCellMediaModel], token: String){
        self.timer = Timer()
        self.steps = steps
        super.init(nibName: "ViewCustomProgramStart", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pauseButton.isHidden = true
        pickStepsTime()
        if (steps[indexSteps].needauth){
            apperageButton.isHidden = false
        }
        else{
            apperageButton.isHidden = true
        }
        //tableview.dataSource = self
//        /tableview.delegate = self
        tableview.register(UINib(nibName: "ProgramStartCell", bundle: nil), forCellReuseIdentifier: "ProgramStartCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var backToString: String = ""
        DispatchQueue.main.async {
            
            self.seconds = self.seconds - self.steps[self.indexSteps].duration
            self.labelTime.text = self.timeString(time: TimeInterval(self.seconds))
            let vcNFC: ViewNFCTime = ViewNFCTime(seconds: self.steps[self.indexSteps].duration)
            
            
                self.steps[self.indexSteps].duration = 1
                self.changeTableCell()
            for message in messages {
                for payloadRecord in message.records {
                    print("test")
                    backToString = String(data: payloadRecord.payload, encoding: String.Encoding.utf8) as String!
                    backToString.remove(at: backToString.startIndex)
                    backToString.remove(at: backToString.startIndex)
                    backToString.remove(at: backToString.startIndex)
                    print(backToString)
                    print("test")
                    // Handle payloadRecord here
                }
                //            for (i, message) in messages.enumerated(){
                //                print(message)
                self.pairStartNfc(sessionId: backToString)
            }
            // Process detected NFCNDEFMessage objects.
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Check the invalidation reason from the returned error.
        if let readerError = error as? NFCReaderError {
            // Show an alert when the invalidation reason is not because of a success read
            // during a single tag read mode, or user canceled a multi-tag read mode session
            // from the UI or programmatically using the invalidate method call.
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(
                    title: "Session Invalidated",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        // A new session instance is required to read new tags.
        self.session = nil
    }
    
    func pairStartNfc(sessionId: String){
        print("Appairage start")
        let parameters: Parameters = [ "token": self.token, "session id": sessionId ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/user/pair/start", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let code = json["code"] as? String
                    let error = json["error"] as? String
                    let status = json["status"] as? String
                    print(error!)
                    if (error == "true"){
                        print(error)
                        print(code)
                    }
                    else{
                        print("good !")
                        let vcNFC: ViewNFCTime = ViewNFCTime(seconds: self.steps[self.indexSteps].duration)
                        
                        vcNFC.token = self.token
                        self.present(vcNFC, animated: true, completion: nil)
                    }
                }
                else{
                    print("Bad")
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramStartCell", for: indexPath) as! ProgramStartCell
        
        tableview.allowsSelection = false
        cell.imageCell.image = base64Convert(base64String: steps[indexPath.item].logo)
        cell.stat = steps[indexPath.item].stat
        cell.seconds = steps[indexPath.item].duration
        cell.labelType.text = steps[indexPath.item].name
        return cell
    }
    
    func pickStepsTime(){
        var secondsStart: Int = 0
        
        for (i, step) in steps.enumerated(){
         secondsStart = secondsStart + step.duration
        }
        seconds = secondsStart
        labelTime.text = timeString(time: TimeInterval(seconds))
    }
    
    func base64Convert(base64String: String?) -> UIImage{
        if (base64String?.isEmpty)! {
            let test: UIImage = UIImage(named: "image_1 2")!
            return (test)
        }
        else {
            
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            if (decodedimage != nil){
                return decodedimage!
            }
            else{
                return UIImage(named: "logo facebook")!
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        apperageButton.isHidden = true
        startButton.isHidden = true
        pauseButton.isHidden = false
        if (indexSteps == 0){
            steps[0].stat = "En cours"
        }
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewCustomProgramStart.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        apperageButton.isHidden = true
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
           self.pauseButton.setTitle("Reprendre",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButton.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AppaireMe(_ sender: Any) {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Hold your iPhone near the item to learn more about it."
        session?.begin()
    }
    
    
    @objc func updateTimer() {
        let alertPopUp = UIAlertController(title: "Felicitation !", message:
            "Vous avez finit votre session", preferredStyle: UIAlertControllerStyle.alert)
        
        alertPopUp.addAction(UIAlertAction(title: "Terminer", style: UIAlertActionStyle.default,handler: nil))
        if seconds < 1 {
            timer.invalidate()
            self.present(alertPopUp, animated: true, completion: nil)
        } else {
            changeTableCell()
            seconds -= 1
            labelTime.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func changeTableCell(){
        if (steps[indexSteps].duration > 1){
        steps[indexSteps].duration = steps[indexSteps].duration - 1
        }
        else{
            steps[indexSteps].duration = steps[indexSteps].duration - 1
            steps[indexSteps].stat = "Fini"
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.pauseButton.setTitle("Reprendre",for: .normal)
            if (indexSteps != steps.count - 1){
                steps[indexSteps + 1].stat = "En cours"
                indexSteps = indexSteps + 1
                if (steps[indexSteps].needauth){
                    apperageButton.isHidden = false
                }
            }
            else{
                pauseButton.isHidden = true
                let alertPopUp = UIAlertController(title: "Félicitation !", message:
                    "Vous avez finit votre session", preferredStyle: UIAlertControllerStyle.alert)
                
                alertPopUp.addAction(UIAlertAction(title: "Terminer", style: UIAlertActionStyle.default,handler: nil))
                steps[indexSteps].duration - 1
                timer.invalidate()
                self.present(alertPopUp, animated: true, completion: nil)
            }
        }
        tableview.reloadData()
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }

}
