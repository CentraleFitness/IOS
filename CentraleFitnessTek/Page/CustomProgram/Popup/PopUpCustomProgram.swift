//
//  PopUpCustomProgram.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 06/10/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import Alamofire

class PopUpCustomProgram: UIViewController, UICollectionViewDataSource{
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var littleView: DesignableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var LaunchButton: UIButton!
    @IBOutlet var labelName: UILabel!
    
    var token: String = ""
    var labelText: String
    var cellIdentifier: String = String(describing: SessionCell.self)
    let steps: [SessionCellMediaModel]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "SessionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self as? UICollectionViewDelegate
        //collectionView.datasource = self
        labelName.text = labelText
        labelDescription.text = ""
        littleView.cornerRadius = 15
        LaunchButton.layer.cornerRadius = 15
        cancelButton.layer.cornerRadius = 15
     //   pickSteps()
        // Do any additional setup after loading the view.
    }
    
    init(name: String, token: String, programtId: String){
        steps = []
        labelText = name
     
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
        
        return cell
    }
    
    func pickSteps(id: Int, event: ProgramEvent, isSuccess: @escaping(_ event: ProgramEvent,_ id: Int)-> Void){
            
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
    
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return
//    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
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
