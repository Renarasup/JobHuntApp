//
//  Job.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import Foundation

struct Job : Decodable {
    
    var slug : String
    var id : String
    var epoch : String
    var date : String
    var company : String // TODO - Change to Date()
    var position : String
    var tags : [String]
    var logo : String
    var description : String
    var url : String
    
    init(json : [String : Any]){
        slug = json["slug"] as! String
        id = json["id"] as! String
        epoch = json["epoch"] as! String
        date = json["date"] as! String
        company = json["company"] as! String
        position = json["position"] as! String
        tags = json["slug"] as! [String]
        logo = json["logo"] as! String
        description = json["description"] as! String
        url = json["url"] as! String
    }
}
