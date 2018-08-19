//
//  ViewProfil.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 18/04/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit

class ViewProfil: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var profil_image = UIImage(named: "Chat")
    @IBOutlet var top_bar_view: UIImageView!
    @IBOutlet var page: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var button_1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(importImage), name: NSNotification.Name(rawValue: "showAlert"), object: nil)
        //myImageView.image = "icone_user_profil"
        //myImageView.image = UIImage(named:#imageLiteral(resourceName: "icone_user_profil"))
        //myImageView = UIImageView(image: profil_image)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
      //  let color = UIColor(named: "color_red")
//        let shadowPath = UIBezierPath(rect: view.bounds)

     /*   top_bar_view.layer.masksToBounds = false
        top_bar_view.layer.shadowColor = color?.cgColor
        top_bar_view.layer.shadowOffset = CGSize(width: 2, height: 4)
        top_bar_view.layer.shadowOpacity = 0.3
        top_bar_view.layer.shadowPath = shadowPath.cgPath
        page.layer.masksToBounds = false
        page.layer.shadowColor = color?.cgColor
        page.layer.shadowOffset = CGSize(width: 2, height: 4)
        page.layer.shadowOpacity = 0.3
        page.layer.shadowPath = shadowPath.cgPath*/
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func importImage()
    {
        print("test")
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        myImageView?.layer.cornerRadius = myImageView.frame.size.width / 2
        myImageView?.clipsToBounds = true
        self.present(image, animated:true)
        {
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            myImageView.image = image
        }
        else
        {
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func press_button_1(_ sender: Any) {
        importImage()
    }
}
