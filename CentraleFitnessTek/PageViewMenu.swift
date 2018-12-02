//
//  PageViewMenu.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 18/04/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class PageViewMenu: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var token: String = ""
    
    lazy var subViewControllers:[UIViewController] = {
       return [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationControllerProfil") as! NavigationControllerProfil,
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewSession") as! ViewSession,
        ViewSocial(nibName: "ViewSocial", bundle: nil)
        //UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewSocial") as! ViewSocial
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        print("Token PageView: ")
        print(token)
        let exo1 = self.subViewControllers[0] as! NavigationControllerProfil
        let exo2 = self.subViewControllers[1] as! ViewSession
        let exo3 = self.subViewControllers[2] as! ViewSocial
        exo1.token = self.token
        exo2.token = self.token
        exo3.token = self.token
        self.view.backgroundColor = UIColor.white
        setViewControllers([subViewControllers[1]], direction: .reverse, animated: false, completion: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableSwipe), name:NSNotification.Name(rawValue: "enableSwipe"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.disableSwipe), name:NSNotification.Name(rawValue: "disableSwipe"), object: nil)
        }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("a")
    }
    
    @objc func disableSwipe(notification: NSNotification){
            self.dataSource = nil
        }
        
    @objc func enableSwipe(notification: NSNotification){
            self.dataSource = self
        }
    
    
    @objc func test(){
        
    }
    /*func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }*/

// MARK: UIPageViewControllerDataSource
func presentationCount(for pageViewController:UIPageViewController) -> Int{
    return subViewControllers.count
}
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex <= 0)
        {
            return nil
        }
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex >= subViewControllers.count-1)
        {
            return nil
        }
        return subViewControllers[currentIndex+1]
    }
}

