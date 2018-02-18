//
//  Job.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import Foundation

struct Job : Decodable {
    
    var id : String
    var created_at : String
    var title : String
    var location : String
    var type : String
    var description : String
    var how_to_apply : String
    var company : String
    var company_url : String?
    var company_logo : String?
    var url : String
    
    init(json : [String : Any]){
        id = json["id"] as! String
        created_at = json["created_at"] as! String
        title = json["title"] as! String
        location = json["location"] as! String
        type = json["type"] as! String
        description = json["description"] as! String
        how_to_apply = json["how_to_apply"] as! String
        company = json["company"] as! String
        company_url = json["company_url"] as? String
        company_logo = json["company_logo"] as? String
        url = json["url"] as! String
    }
}
