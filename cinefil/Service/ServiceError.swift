//
//  ServiceError.swift
//  cinefil
//
//  Created by zhou on 2/15/16.
//  Copyright © 2016 zhou. All rights reserved.
//

struct ServiceError {
    var description: String

    init(error: String) {
        description = error
    }
}
