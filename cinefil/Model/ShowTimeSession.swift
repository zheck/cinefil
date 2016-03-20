//
//  ShowTimeSession.swift
//  cinefil
//
//  Created by zhou on 3/16/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import SwiftyJSON

class ShowTimeSession {

    var version: String
    var format: String
    var scr = [String]()

    init(json: JSON) {
        version = json["version"]["$"].stringValue
        format = json["screenFormat"]["$"].stringValue
        for row in json["scr"][0]["t"].arrayValue {
            scr.append(row["$"].stringValue)
        }
    }

}
