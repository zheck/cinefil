//
//  ShowTime.swift
//  cinefil
//
//  Created by zhou on 3/15/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import SwiftyJSON

class ShowTime {

    var theater: Theater
    var sessions = [ShowTimeSession]()

    init(json: JSON) {
        theater = Theater(json: json["place"]["theater"])
        for row in json["movieShowtimes"].arrayValue {
            sessions.append(ShowTimeSession(json: row))
        }
    }

}
