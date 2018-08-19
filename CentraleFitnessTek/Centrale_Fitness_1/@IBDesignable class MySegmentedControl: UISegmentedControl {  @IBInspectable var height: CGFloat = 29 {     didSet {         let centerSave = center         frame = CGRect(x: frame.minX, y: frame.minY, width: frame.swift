//
//  @IBDesignable class MySegmentedControl: UISegmentedControl {  @IBInspectable var height: CGFloat = 29 {     didSet {         let centerSave = center         frame = CGRect(x: frame.minX, y: frame.minY, width: frame.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 22/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

@IBDesignable class MySegmentedControl: UISegmentedControl {
    
    @IBInspectable var height: CGFloat = 29 {
        didSet {
            let centerSave = center
            frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: height)
            center = centerSave
        }
    }
}

