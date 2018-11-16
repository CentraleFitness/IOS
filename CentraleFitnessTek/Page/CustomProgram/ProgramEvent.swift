//
//  ProgramEvent.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 16/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation

class ProgramEvent{
    var programName:String? = nil
    var programtId:String? = nil
    var favorites:Bool? = nil
    var programPicture:String? = nil
    var programDuration:Int? = nil
    var programNote:String? = nil
    
    static func start_init(Dict: Dictionary<String, Any>) -> ProgramEvent
    {
        let event = ProgramEvent()
        
        event.programName = Dict["name"] as? String
        event.programtId = Dict["custom program id"] as? String
        return event
    }
    
    static func getEventArray(dict: [Dictionary<String, Any>]) -> Array<ProgramEvent>
    {
        var arrayEvent = Array<ProgramEvent>()
        
        var idx = 0
        
        while (idx < dict.count)
        {
            print("test dic")
            let tmp = start_init(Dict: dict[idx])
            arrayEvent.append(tmp)
            idx = idx + 1
        }
        return arrayEvent
    }
    
    static func start_init_2(event: ProgramEvent, Dict: Dictionary<String, Any>) -> ProgramEvent{
        event.programDuration = Dict["duration"] as? Int
       event.programNote = Dict["note"] as? String
        event.programPicture = Dict["logo"] as? String
        print("zfegre")
        print(event.programDuration)
        
        return event
    }
}
