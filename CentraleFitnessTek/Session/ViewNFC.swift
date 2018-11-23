//
//  ViewNFC.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 23/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit
import GaugeView

class ViewNFC: ViewController {
    @IBOutlet private weak var gaugeView: GaugeView!

    override func viewDidLoad() {
        super.viewDidLoad()

        gaugeView.percentage = 80
        gaugeView.thickness = 5
        gaugeView.labelFont = UIFont.systemFontOfSize(40, weight: UIFontWeightThin)
        gaugeView.labelColor = UIColor.lightGrayColor()
        gaugeView.gaugeBackgroundColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view.
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
