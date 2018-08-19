//
//  ViewAffiliateOK.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 23/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class ViewAffiliateOK: UIViewController {
        var token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(token)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources th("at can be recreated.
    }
    
    @IBAction func launch_app(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let exo = storyboard.instantiateViewController(withIdentifier: "home") as! PageViewMenu
        exo.token = self.token;
        self.present(exo, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
