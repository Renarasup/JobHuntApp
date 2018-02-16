//
//  Jobs.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import Foundation

class Job: NSObject {
    
    var slug : String?
    var id : Int?
    var epoch : Int?
    var date : NSDate?
    var company : String?
    var position : String?
    var tags : [Tags]?
    var logo : String?
    var desc : String?
    var url : String?
    
}

class Tags: NSObject {
    var name : String?
}
