//
//  Theater.swift
//  cinefil
//
//  Created by zhou on 3/15/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import SwiftyJSON

class Theater {

    var id: String
    var name: String
    var address: String

    init(json: JSON) {
        id = json["code"].stringValue
        name = json["name"].stringValue
        address = json["address"].stringValue
    }

}
