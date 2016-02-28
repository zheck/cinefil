//
//  Genre.swift
//  cinefil
//
//  Created by zhou on 2/16/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import SwiftyJSON

struct Genre {

    let id: String
    let name: String

    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
    }

    init(id: String, value: String) {
        self.id = id
        self.name = value
    }

}
