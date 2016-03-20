//
//  AllocineManager.swift
//  cinefil
//
//  Created by Fong ZHOU on 07/03/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

class AllocineManager {

    static let instance = AllocineManager()

    let dateFormatter = NSDateFormatter()

    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }

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

    func fetchShowTime(movie: Movie, success: ([ShowTime] -> Void), failure: (ServiceError -> Void)) {
        let params = [
            ("theaters", "C0159,C2954,C0026"),
            ("movie", movie.id),
            ("date", dateFormatter.stringFromDate(NSDate()))
        ]
        AllocineService.instance.fetchShowTimeList(params,
            success: { response in
                var showTimeList = [ShowTime]()
                for row in response["feed"]["theaterShowtimes"].arrayValue {
                    showTimeList.append(ShowTime(json: row))
                }
                success(showTimeList)
            },
            failure: failure
        )
    }

}
