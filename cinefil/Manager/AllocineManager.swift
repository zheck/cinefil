//
//  AllocineManager.swift
//  cinefil
//
//  Created by Fong ZHOU on 07/03/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

class AllocineManager: NSObject {

    static let instance = AllocineManager()

    func fetchMovies(success: ([Movie] -> Void), failure: (ServiceError -> Void)) {
        let params = [
            ("filter", "nowshowing"),
            ("profile", "small"),
            ("order", "toprank"),
            ("count", "20"),
            ("page", "1")
        ]
        AllocineService.instance.fetchMovies(params,
            success: { response in
                var movies = [Movie]()
                for row in response["feed"]["movie"].arrayValue {
                    movies.append(Movie(allocine: row))
                }
                success(movies)
            },
            failure: failure
        )
    }

    func fetchShowTime() {
        AllocineService.instance.fetchShowTimeList()
    }

}
