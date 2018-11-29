//
//  CommentInfo.swift
//  CentraleFitnessTek
//
//  Created by Fabien Santoni on 23/11/2018.
//  Copyright © 2018 Fabien Santoni. All rights reserved.
//

import Foundation
import UIKit

class CommentInfo{
    var name:String? = nil
    var date:Int? = nil
    var comment:String? = nil
    
static func start_init(Dict: Dictionary<String, Any>) -> CommentInfo
{
    let info = CommentInfo()
    
    info.name = Dict["name"] as? String
    info.comment = Dict["comment content"] as? String
    info.date = Dict["date"] as? Int
    print("test id")
    print(info.name)
    return info
}

static func getEventArray(dict: [Dictionary<String, Any>]) -> Array<CommentInfo>
{
    var arrayInfo = Array<CommentInfo>()
    
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

//static func start_init_2(info: CommentInfo, Dict: Dictionary<String, Any>) -> CommentInfo{
//    info.description = Dict["post content"] as? String
//    return info
//}
}
