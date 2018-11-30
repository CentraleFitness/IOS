//
//  ViewConnectionNFC.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 30/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import CoreNFC

class ViewConnectionNFC: UIViewController {
    
    @IBOutlet weak var buttonNFC: UIButton!
    var detectedMessages = [NFCNDEFMessage]()
    var session: NFCNDEFReaderSession?
    var token: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        let vcNFC: ViewNFC = ViewNFC()
        
        vcNFC.token = token
        self.present(vcNFC, animated: true, completion: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
