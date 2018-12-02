//
//  ViewCustomProgramStart.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 19/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class ViewCustomProgramStart: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var indexSteps: Int = 0
    var seconds = 0
    var timer: Timer
    var isTimerRunning = false
    var resumeTapped = false
    
    var steps: [SessionCellMediaModel]
    
    init(steps: [SessionCellMediaModel]){
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
        //tableview.dataSource = self
//        /tableview.delegate = self
        tableview.register(UINib(nibName: "ProgramStartCell", bundle: nil), forCellReuseIdentifier: "ProgramStartCell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
           self.pauseButton.setTitle("Resume",for: .normal)
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
    
    
    @objc func updateTimer() {
        print(seconds)
        let alertPopUp = UIAlertController(title: "Felicitation !", message:
            "Vous avez finit votre session", preferredStyle: UIAlertControllerStyle.alert)
        
        alertPopUp.addAction(UIAlertAction(title: "Terminer", style: UIAlertActionStyle.default,handler: nil))
        if seconds < 1 {
            timer.invalidate()
            self.present(alertPopUp, animated: true, completion: nil)
            //Send alert to indicate time's up.
        } else {
            changeTableCell()
            seconds -= 1
            labelTime.text = timeString(time: TimeInterval(seconds))
            //labelTime.text = String(seconds)
            //            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    func changeTableCell(){
        if (steps[indexSteps].duration > 1){
        steps[indexSteps].duration = steps[indexSteps].duration - 1
        }
        else{
            steps[indexSteps].duration = steps[indexSteps].duration - 1
            steps[indexSteps].stat = "Fini"
            if (indexSteps != steps.count){
                indexSteps = indexSteps + 1
            }
            else{
                return
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
