//
//  MovieManager.swift
//  cinefil
//
//  Created by zhou on 2/15/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

class MovieManager {

    class func getPopularMovies(success: ([Movie] -> Void), failure: (ServiceError -> Void)) {

        MovieDBService.instance.baseRequest(.TopRatedMovies, success: { (response) -> Void in
            var movies: [Movie] = []
            for movie in response["results"].arrayValue {
                movies.append(Movie(json: movie))
            }
            success(movies)

            }) { (error) -> Void in
                failure(ServiceError(error: error.description))
        }

    }

}
