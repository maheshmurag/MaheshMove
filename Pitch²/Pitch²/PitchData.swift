//
//  PitchData.swift
//  Pitch²
//
//  Created by Cluster 5 on 7/9/14.
//  Copyright (c) 2014 Alex Yeh. All rights reserved.
//

import UIKit

class PitchData {
    var score:Int = 0;
    var highscore:Int = 0;
    var scoreArray: Int[] = [];
    
    class var sharedInstance : PitchData {
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : PitchData? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = PitchData()
        }
        return Static.instance!
    }
}

