//
//  Tags.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import Foundation

func displayTagsBullet(_ tagList: [String]) -> String {
    if let tags : [String] = tagList {
        let count = tags.count
        var tagString = ""
        for tag in tags {
            if tags.index(of: tag) != count - 1 {
                tagString += "\(tag.capitalized) • "
            } else {
                tagString += "\(tag.capitalized)"
            }
        }
        return tagString
    }
    
    return "No tags"
}

func populateTagFilter(_ jobs: [Job]) -> Array<String> {
    var set = Set<String>()
    for job in jobs {
        let tagArray = job.tags
        for tag in tagArray {
            set.insert(tag)
        }
    }
    return Array(set)
}
