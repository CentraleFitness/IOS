//
//  Info.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 17/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation

class Info{
    var infoName:String? = nil
    var infoId:String? = nil
    var description:String? = nil
    var picture:String? = nil
    
    static func start_init(Dict: Dictionary<String, Any>) -> Info
    {
        let info = Info()
        
        info.infoName = Dict["post type"] as? String
        info.infoId = Dict["post id"] as? String
        print("test id")
        print(info.infoId)
        return info
    }
    
    static func getEventArrayLittle(dict: [Dictionary<String, Any>]) -> Array<Info>
    {
        var arrayInfo = Array<Info>()
        
        var idx = 0
        
        while (idx < dict.count)
        {
            print("test dic")
            let tmp = start_init(Dict: dict[idx])
            if (tmp.infoName != "EVENT"){
                arrayInfo.append(tmp)
            }
            idx = idx + 1
        }
        return arrayInfo
    }
    
    static func getEventArray(dict: [Dictionary<String, Any>]) -> Array<Info>
    {
        var arrayInfo = Array<Info>()
        
        var idx = 0
        
        while (idx < dict.count)
        {
             print("test dic")
            let tmp = start_init(Dict: dict[idx])
            arrayInfo.append(tmp)
            idx = idx + 1
        }
        return arrayInfo
    }
    
    static func start_init_2(info: Info, Dict: Dictionary<String, Any>) -> Info{
        info.description = Dict["post content"] as? String
        print(info.description)
        //info.picture = Dict["] as? String
        return info
    }
}
