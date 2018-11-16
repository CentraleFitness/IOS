//
//  Event.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 24/05/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation

class Event{
    var eventName:String? = nil
    var eventId:String? = nil
    var user_registered:Bool? = nil
    var description:String? = nil
    var picture:String? = nil
    var start_date:Int? = nil
    var end_date:Int? = nil
    
    static func start_init(array: NSArray) -> Event
    {
        let event = Event()
        
        event.eventName = array[0] as? String
        event.eventId = array[1] as? String
        event.user_registered = array[2] as? Bool
        return event
    }
    
    static func getEventArray(array: NSArray, test: Bool) -> Array<Event>
    {
        var arrayEvent = Array<Event>()
        
        var idx = 0
        
        while (idx < array.count)
        {
            let tmp = start_init(array: (array[idx] as? NSArray)!)
            if (test == true){
                if (tmp.user_registered == true){
                    arrayEvent.append(tmp)
                }
            }
            else{
            arrayEvent.append(tmp)
            }
            idx = idx + 1
        }
        
        return arrayEvent
    }
    
    static func start_init_2(event: Event, Dict: Dictionary<String, Any>) -> Event{
        event.description = Dict["description"] as? String
        event.user_registered = Dict["user_registered"] as? Bool
        event.picture = Dict["picture"] as? String
        event.start_date = Dict["start date"] as? Int
        event.end_date = Dict["end date"] as? Int
        return event
    }
}

