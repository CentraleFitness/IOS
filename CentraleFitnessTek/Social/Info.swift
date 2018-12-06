//
//  Info.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 17/09/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation

class Info{
    var infoIsLike: Bool? = false
    var infoLikes: Int? = 0
    var infoName:String? = nil
    var infoName2:String? = nil
    var infoPostPicture: String? = nil
    var infoPostIcon: String? = nil
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
            if (tmp.infoName == "PUBLICATION"){
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
        info.infoName2 = Dict["name"] as? String
        info.infoPostIcon = Dict["post icon"] as? String
        info.infoPostPicture = Dict["post picture"] as? String
        info.description = Dict["post content"] as? String
        info.infoLikes = Dict["likes"] as? Int
        if (info.infoLikes == nil){
            info.infoLikes = 0
        }
        print(info.description)
        //info.picture = Dict["] as? String
        return info
    }
    
    static func like(info: Info, Dict: Dictionary<String, Any>) -> Info{
        info.infoIsLike = Dict["liked"] as! Bool
        //info.picture = Dict["] as? String
        return info
    }
}
