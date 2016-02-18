//
//  Genre.swift
//  cinefil
//
//  Created by zhou on 2/16/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import SwiftyJSON

struct Genre {

    let id: Int
    let name: String?

    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }

}
