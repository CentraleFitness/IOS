//
//  ViewChallenges.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 21/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import UIKit

class ViewChallenges: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let cellSpacingHeight: CGFloat = 5
    var list: [Challenges] = []
    let bgColorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgColorView.backgroundColor = UIColor.white
        //cell.selectedBackgroundView = bgColorView
        list = createArray()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func createArray() -> [Challenges] {
        var list_challenges: [Challenges] = []
        
        let challenge_1 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: true)
        let challenge_2 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 2"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: false)
        let challenge_3 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 3"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: true)
        let challenge_4 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 4"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: true)
        let challenge_5 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 5"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: false)
        let challenge_6 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 6"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: false)
        let challenge_7 = Challenges(event_description: "test", event_picture: #imageLiteral(resourceName: "image_1 7"), event_start_date: "13:00", event_end_date: "15:00", event_user_registered: false)
        
        list_challenges.append(challenge_1)
        list_challenges.append(challenge_2)
        list_challenges.append(challenge_3)
        list_challenges.append(challenge_4)
        list_challenges.append(challenge_5)
        list_challenges.append(challenge_6)
        list_challenges.append(challenge_7)
        
        return list_challenges
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension  ViewChallenges: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let challenges = list[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ChallengesCell", owner: self, options: nil)?.first as! ChallengesCell //tableView.dequeueReusableCell(withIdentifier: "challengesCell") as! ChallengesCell
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.setChallenges(challenges: challenges)
        return cell
    }
}
