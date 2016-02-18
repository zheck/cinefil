//
//  MovieManager.swift
//  cinefil
//
//  Created by zhou on 2/15/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

class MovieManager {

    class func getMovieGenre(success: ([Genre] -> Void), failure: (ServiceError -> Void)) {
        MovieDBService.instance.baseRequest(.MovieGenres, success: { (response) -> Void in
            var genres: [Genre] = []
            for genre in response["genres"].arrayValue {
                genres.append(Genre(json: genre))
            }
            success(genres)

            }) { (error) -> Void in
                failure(ServiceError(error: error.description))
        }
    }

    class func getPopularMovies(success: ([Movie] -> Void), failure: (ServiceError -> Void)) {

        MovieDBService.instance.baseRequest(.PopularMovies, success: { (response) -> Void in
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
