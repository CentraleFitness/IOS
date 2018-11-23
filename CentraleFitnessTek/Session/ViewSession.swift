//
//  ViewSession.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 18/04/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit
import CoreNFC

class ViewSession: UIViewController, NFCNDEFReaderSessionDelegate{
    
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
    var token: String = ""
    let reuseIdentifier = "reuseIdentifier"
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?

    var viewChallenges: ViewChallenges?
    var viewDefi: ViewDefi?
    var viewStatistics: ViewStatistics?
    var viewCustomProgram: ViewCustomProgram?
    var viewInstant: ViewInstant?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewChallenges = ViewChallenges()
        viewChallenges?.token = self.token
        viewDefi = ViewDefi()
        viewDefi?.token = self.token
        viewStatistics = ViewStatistics()
        viewStatistics?.token = self.token
        viewCustomProgram = ViewCustomProgram()
        viewCustomProgram?.token = self.token
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
        //self.ActionOnSideMenuButtons(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// - Tag: processingTagData
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            // Process detected NFCNDEFMessage objects.
            self.detectedMessages.append(contentsOf: messages)
        }
    }
    
    /// - Tag: endScanning
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
    
    @IBAction func beginScanning(_ sender: Any) {
        let vc: ViewNFC = ViewNFC()
        
        vc.present(vc, animated: true, completion: nil)
//        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
//        session?.alertMessage = "Hold your iPhone near the item to learn more about it."
//        session?.begin()
    }
    
    @IBAction func pulseButtonNFC(_ sender: UIButton) {
      //  sender.pulsate2()
     //   session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
      //  session?.alertMessage = "Hold your iPhone near the item to learn more about it."
       // session?.begin()
       // label_connection.text = "Connexion en cours.."
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
        activeViewController = viewDefi
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
