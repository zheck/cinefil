//
//  Movie.swift
//  cinefil
//
//  Created by zhou on 2/13/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import SwiftyJSON

struct Movie {

    let title: String?

    init(json: JSON) {
        title = json["title"].stringValue
    }

}
