//
//  ViewDefi.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 16/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class ViewDefiOld: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var PourcentBigThunder: UIView?
    @IBOutlet weak var thunde1: UIImageView?
    @IBOutlet weak var thunde2: UIImageView?
    @IBOutlet weak var thunde3: UIImageView?
    @IBOutlet weak var label_pourcentage: UILabel?
    
    let items = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let pieChart = PieChart(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
    
    var pourcentage: Int = 0
    var kwh: Int = 19000
    var argent: Int = 10000
    var or: Int = 20000
    var diamand: Int = 30000
    var token: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "DefiCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DefiCollectionCell")
        init_thunder()
         let pieChart = PieChart(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
        pieChart.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefiCell", for: indexPath) as! DefiCollectionCell

        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefiCollectionCell", for: indexPath) as! DefiCollectionCell

       // let cell = Bundle.main.loadNibNamed("DefiCollectionCell", owner: self, options: nil)?.first as! DefiCollectionCell
        cell.label_cell.text = items[indexPath.item]  		
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    

    func init_thunder()
    {
        if (self.kwh < self.argent)
        {
            pourcentage = (kwh * 100) / argent
            pieChart.setst(test: pourcentage + 25)
            label_pourcentage?.text = String(kwh) + "/" + String(argent) + " Kwh"
            thunde2?.image = UIImage(named: "DefiThunderBronze")
            thunde3?.image = UIImage(named: "DefiThunderArgent")
        }
        else if (self.kwh < self.or)
        {
            pourcentage = (kwh * 100) / or
            pieChart.setst(test: pourcentage + 25)
            label_pourcentage?.text = String(kwh) + "/" + String(or) + " Kwh"
            thunde1?.image = UIImage(named: "DefiThunderBronze")
            thunde2?.image = UIImage(named: "DefiThunderArgent")
            thunde3?.image = UIImage(named: "DefiThunderOr")
        }
        else
        {
            pourcentage = (kwh * 100) / diamand
            pieChart.setst(test: pourcentage + 25)
            thunde1?.image = UIImage(named: "DefiThunderArgent")
            thunde2?.image = UIImage(named: "DefiThunderOr")
            label_pourcentage?.text = String(kwh) + "/" + String(diamand) + " Kwh"
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
