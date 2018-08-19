//
//  ViewSession.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 18/04/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit

class ViewSession: UIViewController {
    
    @IBOutlet weak var top_contentView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label_connection: UILabel!
    @IBOutlet weak var button_challenges: UIButton!
    @IBOutlet weak var button_events: UIButton!
    @IBOutlet weak var button_start: UIButton!
    @IBOutlet weak var button_statistics: UIButton!
    @IBOutlet weak var button_custom: UIButton!
    @IBOutlet var top_bar_view: UIImageView!
    @IBOutlet weak var top_bar_2: UIButton!
    @IBOutlet weak var button_NFC: UIButton!
    
    var page_stat: boolean_t!
    var button_stat: Int!

    var viewChallenges: ViewChallenges?
    var viewEvents: ViewEvents?
    var viewStatistics: ViewStatistics?
    var viewCustomProgram: ViewCustomProgram?
    var viewInstant: ViewInstant?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewChallenges = ViewChallenges()
        viewEvents = ViewEvents()
        viewStatistics = ViewStatistics()
        viewCustomProgram = ViewCustomProgram()
        viewInstant = ViewInstant()
        
        NotificationCenter.default.addObserver(self, selector: #selector(bar_down), name: NSNotification.Name(rawValue: "barDown"), object: nil)
        
        let active_top = viewInstant
        addChildViewController(active_top!)
        active_top?.view.frame = top_contentView.bounds
        top_contentView.addSubview((active_top?.view)!)
        
        // call before adding child view controller's view as subview
        active_top?.didMove(toParentViewController: self)
        button_stat = 0
        //self.contentView.layer.cornerRadius = 25
        self.contentView.layer.position.y = 980
        page_stat = 0
      //  let color = UIColor(named: "color_red")
//        let shadowPath = UIBezierPath(rect: view.bounds)
        
     /*   top_bar_view.layer.masksToBounds = false
        top_bar_view.layer.shadowColor = color?.cgColor
        //top_bar_view.layer.shadowOffset = CGSize(width: 2, height: 4)
        top_bar_view.layer.shadowOpacity = 0.1
        top_bar_view.layer.shadowPath = shadowPath.cgPath
        
        top_bar_2.layer.masksToBounds = false
        top_bar_2.layer.shadowColor = color?.cgColor
        //top_bar_2.layer.shadowOffset = CGSize(width: 2, height: 4)
        top_bar_2.layer.shadowOpacity = 0.1
        top_bar_2.layer.shadowPath = shadowPath.cgPath*/
        
       /* contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = color?.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 4)
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.shadowPath = shadowPath.cgPath*/
     //   contentView.clipsToBounds = true
        //contentView.layer.cornerRadius = 25
        
        /*    //navController1
         let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "HomeVC") as! ViewChallenge
         navController1 = UINavigationController(rootViewController: VC1)
         navController1?.isNavigationBarHidden = true
         
         //navController2
         let VC2 = self.storyboard!.instantiateViewController(withIdentifier: "UIViewController")
         navController2 = UINavigationController(rootViewController: VC2)
         navController2?.isNavigationBarHidden = true
         
         //navController3
         let VC3 = self.storyboard!.instantiateViewController(withIdentifier: "UIViewController")
         navController3 = UINavigationController(rootViewController: VC3)
         navController3?.isNavigationBarHidden = true
         
         //navController4
         let VC4 = self.storyboard!.instantiateViewController(withIdentifier: "UIViewController")
         navController4 = UINavigationController(rootViewController: VC4)
         navController4?.isNavigationBarHidden = true
         
         let btn = UIButton()
         btn.tag = 1*/
        //self.ActionOnSideMenuButtons(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pulseButtonNFC(_ sender: UIButton) {
        sender.pulsate2()
        label_connection.text = "Connexion en cours.."
    }
    
    @IBAction func press_button_center(_ sender: UIButton) {
        sender.pulsate()
        print("press_button_center")
        if (page_stat == 1)
        {
            page_stat = 0
            UIView.animate(withDuration: 1) {
                self.contentView.layer.position.y = 980.00
            }
        }
        else if (page_stat == 0)
        {
            page_stat = 1
            UIView.animate(withDuration: 1) {
                self.contentView.layer.position.y = 380.00
            }
        }
    }
    
    @IBAction func press_button_challenge(_ sender: UIButton) {
        sender.pulsate()
        print("press_button_challenge")
        if (page_stat == 0)
        {            
            print("stat = 0")
            page_stat = 1
            UIView.animate(withDuration: 0.5) {

                self.contentView.layer.position.y = 380.00
            }
        }
        else
        {
            print("stat = 1")
        }
        UIView.animate(withDuration: 0.3) {
        self.button_challenges.layer.position.y = 635
        self.button_events.layer.position.y = 644
        self.button_statistics.layer.position.y = 644
        self.button_custom.layer.position.y = 644
        }
        activeViewController = viewChallenges
        
    }
    
    @IBAction func press_button_events(_ sender: UIButton) {
        sender.pulsate()
        print("press_events")
        if (page_stat == 0)
        {
            page_stat = 1
            UIView.animate(withDuration: 0.5) {
                self.contentView.layer.position.y = 380.00
            }
        }
        else
        {
        }
        UIView.animate(withDuration: 0.3) {
        self.button_challenges.layer.position.y = 644
        self.button_events.layer.position.y = 635
        self.button_statistics.layer.position.y = 644
        self.button_custom.layer.position.y = 644
        }
        activeViewController = viewEvents
    }
    
    @objc func bar_down()
    {
        print(self.top_contentView.layer.position.y)
        if (self.top_contentView.layer.position.y == 300.00){
            UIView.animate(withDuration: 0.5) {
                self.top_contentView.layer.position.y = -167.0
            }
        }
        else{
        UIView.animate(withDuration: 0.5) {
        self.top_contentView.layer.position.y = 300.00
        }
        }
    }
    
    @IBAction func press_button_statistics(_ sender: UIButton) {
        sender.pulsate()
        print("press_statistics")
        if (page_stat == 0)
        {
            page_stat = 1
            UIView.animate(withDuration: 0.5) {
                self.contentView.layer.position.y = 380.00
            }
        }
        else
        {
        }
        UIView.animate(withDuration: 0.3) {
        self.button_challenges.layer.position.y = 644
        self.button_events.layer.position.y = 644
        self.button_statistics.layer.position.y = 635
        self.button_custom.layer.position.y = 644
        }
        activeViewController = viewStatistics
        
    }
    
    @IBAction func press_button_custom_program(_ sender: UIButton) {
        sender.pulsate()
        print("press_custom_program")
        if (page_stat == 0)
        {
            page_stat = 1
            UIView.animate(withDuration: 0.5) {
                self.contentView.layer.position.y = 380.00
            }
        }
        else
        {
        }
        UIView.animate(withDuration: 0.3) {
        self.button_challenges.layer.position.y = 644
        self.button_events.layer.position.y = 644
        self.button_statistics.layer.position.y = 644
        self.button_custom.layer.position.y = 635
        }
        activeViewController = viewCustomProgram
    }
    
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            // call before removing child view controller's view from hierarchy
            inActiveVC.willMove(toParentViewController: nil)
            
            inActiveVC.view.removeFromSuperview()
            
            // call after removing child view controller's view from hierarchy
            inActiveVC.removeFromParentViewController()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            // call before adding child view controller's view as subview
            addChildViewController(activeVC)
            
            activeVC.view.frame = contentView.bounds
            contentView.addSubview(activeVC.view)
            
            // call before adding child view controller's view as subview
            activeVC.didMove(toParentViewController: self)
        }
    }
    /*private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            // call before removing child view controller's view from hierarchy
            inActiveVC.willMove(toParentViewController: nil)
            
            inActiveVC.view.removeFromSuperview()
            
            // call after removing child view controller's view from hierarchy
            inActiveVC.removeFromParentViewController()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            // call before adding child view controller's view as subview
            addChildViewController(activeVC)
            
            activeVC.view.frame = contentView.bounds
            contentView.addSubview(activeVC.view)
            
            // call before adding child view controller's view as subview
            activeVC.didMove(toParentViewController: self)
        }
    }
    
    @IBAction func press_challenge(_ sender: Any) {
        activeViewController = firstViewController
    }
    @IBAction func press_events(_ sender: Any) {
        activeViewController = secondViewController
    }*/
    // Example of using the extension on button press
    /* @IBAction func pulseButtonPressed(_ sender: UIButton) {
     sender.pulsate()
     }
     @IBAction func pulseButtonChallenge(_ sender: UIButton) {
     for view in containerViewA.subviews{
     view.removeFromSuperview()
     }
     addChildViewController(self.navController1!)
     self.navController1?.view.frame = self.containerViewA.bounds
     self.containerViewA.addSubview((navController1?.view)!)
     }*/
}
