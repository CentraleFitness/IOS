//
//  PieChart.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 17/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit

class PieChart : UIView {
    var startPercent: Int = 0
    var endPercent: Int = 25
    
    override func draw(_ rect: CGRect) {
        
        drawSlice(rect, startPercent: CGFloat(startPercent), endPercent: CGFloat(endPercent), color: .green)
    }
    
    func setst(test: Int)
    {
        self.startPercent = test
    }
    
    private func drawSlice(_ rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let startAngle = startPercent / 100 * CGFloat.pi * 2 - CGFloat.pi
        let endAngle = endPercent / 100 * CGFloat.pi * 2 - CGFloat.pi
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        color.setFill()
        path.fill()
    }
}
