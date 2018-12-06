//
//  ViewChallenges.swift
//  Centrale_Fitness_1
//
//  Created by Fabien Santoni on 21/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import PopupDialog
import Alamofire
import UIKit

class ViewChallenges: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button_refresh: UIButton!
    var token: String = ""
    
    var userRegister: Bool = false
    let cellSpacingHeight: CGFloat = 5
    var list: [Challenges] = []
    var list_events: Array<Event> = []
    let bgColorView = UIView()
    var last_choice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgColorView.backgroundColor = UIColor.white
        createArray()
    }
    
    func createArray() {
        var test: NSArray!
        print("Start Events")
        
        var list_challenges: [Challenges] = []
        let parameters: Parameters = [
            "token": self.token,
            "isreg": true,
            "start": 0,
            "end": 100
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/events", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    let code = json["code"] as? String
                    print(error!)
                    print(code!)
                    if (error == "false")
                    {
                        print("Start Events2")
                        test = json["events"] as? NSArray
                        self.list_events.removeAll()
                        self.list_events = Event.getEventArray(array: test,test: self.userRegister)
                        self.fill_event()
                        self.tableView.reloadData()
                    }
                }
                else
                {
                    print("Bad")
                }
        }
        //return list_challenges
    }
    
    func fill_event()
    {
        var idx = 0
        
        while(idx < list_events.count)
        {
            getEventPreview(id: idx, event: list_events[idx]) { (event, idx) in
                self.list_events[idx] = event
                self.tableView.reloadData()
            }
            idx = idx + 1
        }
        //self.tableView.reloadData()
    }
    
    func getEventPreview(id: Int, event: Event, isSuccess: @escaping(_ event: Event,_ id: Int)-> Void){
        
        print("Start Events")
        
        let parameters: Parameters = [
            "token": self.token,
            "eventid": event.eventId!
        ]
        
        Alamofire.request("\(network.ipAdress.rawValue)/get/eventpreview", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    _ = json["user_registered"] as? Bool
                    isSuccess(Event.start_init_2(event: event, Dict: json), id)
                }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showStandardDialog(animated: Bool = true, isRegister: Bool) {
        
        // Prepare the popup
        let title = "Voulez-vous vous inscrire à cet évènement"
        let message = ""
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: true,
                                hideStatusBar: true) {
                                    print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "Annuler") {
            // self.label.text = "You canceled the default dialog"
        }
        
        // Create second button
        var text: String = ""
        if (isRegister == false){
            text = "Je m'inscris !"
        }
        else{
            text = "Je me desinscris !"
        }
        let buttonTwo: PopupDialogButton
        if (isRegister == false){
            buttonTwo = DefaultButton(title: "Je m'inscris !") {
                self.subscribe_event()
            }
        }
        else{
            buttonTwo = DefaultButton(title: "Je me desinscris !") {
                self.subscribe_event()
            }
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    func subscribe_event(){
        
        print("Start Subscribe")
        
        let parameters: Parameters = [
            "token": self.token,
            "eventid": list_events[last_choice].eventId!
        ]
        
        
        Alamofire.request("\(network.ipAdress.rawValue)/event/registration", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true"){
                    }
                    else{
                        print("good inscription")
                    }
                }
                else{
                    print("Bad")
                }
                
        }
    }
    
    func desubscribe_event(){
        
        print("Start Subscribe")
        
        let parameters: Parameters = [
            "token": self.token,
            "eventid": list_events[last_choice].eventId!
        ]
        
        
        Alamofire.request("\(network.ipAdress.rawValue)/event/registration", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    let error = json["error"] as? String
                    print(error!)
                    if (error == "true"){
                    }
                    else{
                        print("good desinscription")
                    }
                }
                else{
                    print("Bad")
                }
                
        }
    }
}

extension  ViewChallenges: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_events.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        last_choice = indexPath.row
        if (list_events[indexPath.item].user_registered!) {
            let alertPopUp = UIAlertController(title: "Vous êtes déjà inscrit !", message:
                "", preferredStyle: UIAlertControllerStyle.alert)
            
            alertPopUp.addAction(UIAlertAction(title: "Terminer", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertPopUp, animated: true)
        }
        else{
            showStandardDialog(animated: true, isRegister: false)
        }
        print(indexPath.row)
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //     let challenges = list[indexPath.row]
        let event = list_events[indexPath.item]
        let cell = Bundle.main.loadNibNamed("ChallengesCell", owner: self, options: nil)?.first as! ChallengesCell //tableView.dequeueReusableCell(withIdentifier: "challengesCell") as! ChallengesCell
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
        cell.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.setChallenges(challenges: event)
        return cell
    }
    
    @IBAction func anim1(_ sender: Any) {
        createArray()
        tableView.reloadData(
            with: .simple(duration: 0.75, direction: .rotation3D(type: .ironMan),
                          constantDelay: 0))
    }
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        print("go to segment")
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            userRegister = false
        case 1:
            userRegister = true
        default:
            break
        }
        print("go to segment2")
        print(userRegister)
        self.list_events.removeAll()
        createArray()
        tableView.reloadData(
            with: .simple(duration: 1, direction: .rotation3D(type: .ironMan),
                          constantDelay: 0))
    }
    
}

public extension UITableView {
    
    typealias Complition = (() -> Void)
    typealias HeaderFooterTuple = (header: UIView?, footer: UIView?)
    typealias VisibleHeaderFooter = [Int: HeaderFooterTuple]
    
    public enum AnimationType {
        case simple(duration: TimeInterval, direction: Direction, constantDelay: TimeInterval)
        case spring(duration: TimeInterval, damping: CGFloat, velocity: CGFloat, direction: Direction, constantDelay: TimeInterval)
        
        public func animate(tableView: UITableView, reversed: Bool = false, completion: Complition? = nil) {
            var duration: TimeInterval!
            var damping: CGFloat = 1
            var velocity: CGFloat = 0
            var constantDelay: TimeInterval!
            var direction: Direction!
            
            switch self {
            case .simple(let _duration, let _direction, let _constantDelay):
                duration = _duration
                direction = _direction
                constantDelay = _constantDelay
            case .spring(let _duration, let _damping, let _velocity, let _direction, let _constantDelay):
                duration = _duration
                damping = _damping
                velocity = _velocity
                direction = _direction
                constantDelay = _constantDelay
            }
            
            let _ = tableView.visibleCells
            let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows
            let grouped = indexPathsForVisibleRows?.grouped(by: { (indexPath: IndexPath) -> Int in
                return indexPath.section
            }).sorted(by: { $0.key < $1.key })
            
            let visibleHeaderFooter = tableView.visibleSectionIndexes()
            var visibleViews = [UIView]()
            
            for items in grouped! {
                var currentViews: [UIView] = items.value.flatMap { tableView.cellForRow(at: $0) }
                if let header = visibleHeaderFooter[items.key]?.header {
                    currentViews.insert(header, at: 0)
                }
                
                if let footer = visibleHeaderFooter[items.key]?.footer {
                    currentViews.append(footer)
                }
                
                visibleViews += currentViews
            }
            
            let visibleCellsCount = Double(visibleViews.count)
            let cells = direction.reverse(for: reversed ? visibleViews.reversed() : visibleViews)
            cells.enumerated().forEach { item in
                let delay: TimeInterval = duration / visibleCellsCount * Double(item.offset) + Double(item.offset) * constantDelay
                direction.startValues(tableView: tableView, for: item.element)
                let anchor = item.element.layer.anchorPoint
                
                UIView.animate(
                    withDuration: duration,
                    delay: delay,
                    usingSpringWithDamping: damping,
                    initialSpringVelocity: velocity,
                    options: .curveEaseInOut,
                    animations: {
                        direction.endValues(tableView: tableView, for: item.element)
                }, completion: { finished in
                    item.element.layer.anchorPoint = anchor
                    completion?()
                })
                
                //                print(duration, delay)
            }
            
        }
    }
    
    public enum Direction {
        case left(useCellsFrame: Bool)
        case top(useCellsFrame: Bool)
        case right(useCellsFrame: Bool)
        case bottom(useCellsFrame: Bool)
        case rotation(angle: Double)
        case rotation3D(type: TransformType)
        
        // For testing only
        init?(rawValue: Int, useCellsFrame: Bool) {
            switch rawValue {
            case 0:
                self = Direction.left(useCellsFrame: useCellsFrame)
            case 1:
                self = Direction.top(useCellsFrame: useCellsFrame)
            case 2:
                self = Direction.right(useCellsFrame: useCellsFrame)
            case 3:
                self = Direction.bottom(useCellsFrame: useCellsFrame)
            case 4:
                self = Direction.rotation(angle: -Double.pi / 2)
            default:
                return nil
            }
        }
        
        func startValues(tableView: UITableView, for cell: UIView) {
            cell.alpha = 0
            switch self {
            case .left(let useCellsFrame):
                cell.frame.origin.x += useCellsFrame ? cell.frame.width : tableView.frame.width
            case .top(let useCellsFrame):
                cell.frame.origin.y += useCellsFrame ? cell.frame.height : tableView.frame.height
            case .right(let useCellsFrame):
                cell.frame.origin.x -= useCellsFrame ? cell.frame.width : tableView.frame.width
            case .bottom(let useCellsFrame):
                cell.frame.origin.y -= useCellsFrame ? cell.frame.height : tableView.frame.height
            case .rotation(let angle):
                cell.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            case .rotation3D(let type):
                type.set(for: cell)
            }
        }
        
        func endValues(tableView: UITableView, for cell: UIView) {
            cell.alpha = 1
            switch self {
            case .left(let useCellsFrame):
                cell.frame.origin.x -= useCellsFrame ? cell.frame.width : tableView.frame.width
            case .top(let useCellsFrame):
                cell.frame.origin.y -= useCellsFrame ? cell.frame.height : tableView.frame.height
            case .right(let useCellsFrame):
                cell.frame.origin.x += useCellsFrame ? cell.frame.width : tableView.frame.width
            case .bottom(let useCellsFrame):
                cell.frame.origin.y += useCellsFrame ? cell.frame.height : tableView.frame.height
            case .rotation(_):
                cell.transform = .identity
            case .rotation3D(_):
                cell.layer.transform = CATransform3DIdentity
            }
        }
        
        func reverse(for cells: [UIView]) -> [UIView] {
            switch self {
            case .bottom(_):
                return cells.reversed()
            default:
                return cells
            }
        }
        
        public enum TransformType {
            case ironMan
            case thor
            case spiderMan
            case captainMarvel
            case hulk
            case daredevil
            case deadpool
            case doctorStrange
            
            func set(for cell: UIView) {
                let oldFrame = cell.frame
                var transform = CATransform3DIdentity
                transform.m34 = 1.0 / -500
                
                switch self {
                case .ironMan:
                    cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 0)
                case .thor:
                    cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 0, 1, 0)
                case .spiderMan:
                    cell.layer.anchorPoint = .zero
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 1)
                case .captainMarvel:
                    cell.layer.anchorPoint = CGPoint(x: 1, y: 1)
                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 1, 1, 1)
                case .hulk:
                    cell.layer.anchorPoint = CGPoint(x: 1, y: 1)
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 1, 1, 1)
                case .daredevil:
                    cell.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 0)
                case .deadpool:
                    cell.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 1, 0, 1)
                case .doctorStrange:
                    cell.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 1, 0, 0)
                }
                
                cell.frame = oldFrame
                cell.layer.transform = transform
            }
        }
    }
    
    public func reloadData(with animation: AnimationType, reversed: Bool = false, completion: Complition? = nil) {
        reloadData()
        animation.animate(tableView: self, reversed: reversed, completion: completion)
    }
}

extension UITableView {
    fileprivate func visibleSectionIndexes() -> VisibleHeaderFooter {
        let visibleTableViewRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: bounds.size.width, height: bounds.size.height)
        
        var visibleHeaderFooter: VisibleHeaderFooter = [:]
        (0..<numberOfSections).forEach {
            let headerRect = rectForHeader(inSection: $0)
            let footerRect = rectForFooter(inSection: $0)
            
            let header: UIView? = visibleTableViewRect.intersects(headerRect) ? headerView(forSection: $0) : nil
            let footer: UIView? = visibleTableViewRect.intersects(footerRect) ? footerView(forSection: $0) : nil
            
            let headerFooterTuple: HeaderFooterTuple = (header: header, footer: footer)
            visibleHeaderFooter[$0] = headerFooterTuple
        }
        
        return visibleHeaderFooter
    }
}

extension Array {
    fileprivate func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}





