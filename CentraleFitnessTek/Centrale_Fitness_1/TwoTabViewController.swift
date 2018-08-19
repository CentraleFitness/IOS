//
//  TwoTabViewController.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 15/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit

class TwoTabViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var button_challenges: UIButton!
    @IBOutlet weak var button_events: UIButton!
    
    var firstViewController: UIViewController?
    var secondViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapFirstButton(sender: AnyObject) {
        activeViewController = firstViewController
    }
    
    @IBAction func didTapSecondButton(sender: AnyObject) {
        activeViewController = secondViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
