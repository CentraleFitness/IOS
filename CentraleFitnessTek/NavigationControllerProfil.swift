//
//  NavigationControllerProfil.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 23/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class NavigationControllerProfil: UINavigationController {
    
    let vp = ViewProfil()
    var token: String = ""
    
   /* public init() {
        super.init(rootViewController: vp)
        self.vp.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("NavigationControllerProfil")
        print(token)
        
        if let rootViewController = viewControllers.first as? ViewProfil {
            rootViewController.token = self.token
        }
        
        
        /*  NotificationCenter.default.addObserver(self, selector: #selector(getToken), name: NSNotification.Name(rawValue: "getToken"), object: String())*/
       /* let myVC = storyboard?.instantiateViewController(withIdentifier: "ViewProfil") as! ViewProfil
        myVC.token = self.token
        navigationController?.pushViewController(myVC, animated: true)*/
        // Do any additional setup after loading the view.
    }
    
   /* @objc func getToken() -> String
    {
        return token
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navVC = segue.destination as? NavigationControllerProfil
        
        let tableVC = navVC?.viewControllers.first as! ViewProfil
        
        tableVC.token = self.token
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
