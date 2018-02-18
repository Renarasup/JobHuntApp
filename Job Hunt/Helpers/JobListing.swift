//
//  JobListing.swift
//  Job Hunt
//
//  Created by Raphael on 2/17/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import Foundation

var jobs = [Job]()
var jobsToday = [Job]()
var jobsYesterday = [Job]()
var jobsThisWeek = [Job]()
var jobsLastMonth = [Job]()
var tags = ["PHP", "Rails", "Python", "JavaScript", "Scala", "Android", "iOS", "Linux", "Erlang"]
var selectedTag = ""
var isFilterOn = false
var jobsFiltered = [Job]()

// Get Beetween
func getPostedBeetween(start: Int, end: Int) -> [Job]{
    var filtered = [Job]()
    let formatter = DateFormatter()
    formatter.dateFormat = "E MMM d HH:mm:ss z yyyy"
    let today = Date()
    var date = Calendar.current.date(byAdding: .day, value: -start, to: today)!
    for _ in start...end{
        let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: date)
        for job in jobs {
            let jobDate = formatter.date(from: job.created_at)
            let jobDateDay = Calendar.current.component(.day, from: jobDate!)
            let jobDateMonth = Calendar.current.component(.month, from: jobDate!)
            let dayDate = date
            let dayDateDay = Calendar.current.component(.day, from: dayDate)
            let dayDateMonth = Calendar.current.component(.month, from: dayDate)
            if jobDateDay == dayDateDay && jobDateMonth == dayDateMonth {
                filtered.append(job)
            }
        }
        date = tomorrow!
    }
    
    return filtered
}
