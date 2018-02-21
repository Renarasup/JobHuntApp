//
//  Saved.swift
//  Job Hunt
//
//  Created by Raphael on 2/19/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import RealmSwift

class SavedJob: Object {
    @objc dynamic var id = ""
    @objc dynamic var created_at = ""
    @objc dynamic var title = ""
    @objc dynamic var location = ""
    @objc dynamic var type = ""
    @objc dynamic var desc = ""
    @objc dynamic var how_to_apply = ""
    @objc dynamic var company = ""
    @objc dynamic var company_url = ""
    @objc dynamic var company_logo = ""
    @objc dynamic var url = ""
}
