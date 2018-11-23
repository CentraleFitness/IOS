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
    var infoName:String? = nil
    var infoId:String? = nil
    var description:String? = nil
    var picture:String? = nil
    
static func start_init(Dict: Dictionary<String, Any>) -> CommentInfo
{
    let info = CommentInfo()
    
    info.infoName = Dict["post type"] as? String
    info.infoId = Dict["post id"] as? String
    print("test id")
    print(info.infoId)
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

static func start_init_2(info: CommentInfo, Dict: Dictionary<String, Any>) -> CommentInfo{
    info.description = Dict["post content"] as? String
    return info
}
}
