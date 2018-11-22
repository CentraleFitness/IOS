//
//  PopUpCustomProgram.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 06/10/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire

class PopUpCustomProgram: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var littleView: DesignableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var LaunchButton: UIButton!
    @IBOutlet var labelName: UILabel!
    
    var programId: String = ""
    var token: String = ""
    var labelText: String
    var cellIdentifier: String = String(describing: SessionCell.self)
    var steps: [SessionCellMediaModel]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickSteps()
        collectionView.register(UINib(nibName: "SessionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.delegate = self as? UICollectionViewDelegate
        labelName.text = labelText
        labelDescription.text = "Voulez vous lancer le programme ?"
        littleView.cornerRadius = 15
        LaunchButton.layer.cornerRadius = 15
        cancelButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    init(name: String, token: String, programId: String){
        self.programId = programId
        self.token = token
        self.steps = []
        self.labelText = name
     
        super.init(nibName: "PopUpCustomProgram", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SessionCell
        
        cell.viewModel = steps[indexPath.item]
        return cell
    }
    
    func pickSteps(){
            
            print("Start Events")
            
            let parameters: Parameters = [
                "token": self.token,
                "custom program id": self.programId
            ]
        print(self.token)
        print(self.programId)
            Alamofire.request("\(network.ipAdress.rawValue)/customProgram-get-steps", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    if let json = response.result.value as? [String: Any] {
                        print(json["code"] as Any)
                        let json2 = json["steps"] as? [Dictionary<String, Any>]
                        print("test")
                        print(json2?.count)
                        print("test")
                        self.createSteps(dict: json2!)
                        self.collectionView.reloadData()
                    }
            }
    }
    
    func createSteps(dict: [Dictionary<String, Any>]){
        var i: Int = 0
        var stepModel: SessionCellMediaModel
        
        while(i != dict.count){
            stepModel =  SessionCellMediaModel(logo: dict[i]["icon"] as! String,
                                                                         name: dict[i]["name"] as! String,
                                                                         duration: dict[i]["time"] as! Int,
                                                                         needauth: false)
            i = i + 1
            steps.append(stepModel)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func launchButtonPressed(_ sender: Any) {
        let vc: ViewCustomProgramStart = ViewCustomProgramStart(steps: steps)
        self.present(vc, animated: true, completion: nil)
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
