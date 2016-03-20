//
//  MovieGenreManager.swift
//  cinefil
//
//  Created by Fong ZHOU on 29/02/16.
//  Copyright © 2016 zhou. All rights reserved.
//

class MovieManager {

    static let instance = MovieManager()

    var genres: [String: Genre] = Dictionary()

    init() {
    }

    func fetchGenres(success: (Void -> Void), failure: (ServiceError -> Void)) {
        MovieDBService.instance.fetchtMovieGenres(
            { response in
                self.genres = response
                success()
            },
            failure: failure
        )
    }

    func getGenresStringForMovie(movie: Movie) -> String {
        guard movie.genres.count != 0 else { return "" }
        return ""
        //        return movie.genres.map( { genres[$0]!.name} ).joinWithSeparator(", ")
    }

    func fetchAdditionnalInformation(movie: Movie, success: (Void -> Void), failure: (ServiceError -> Void)) {
        MovieDBService.instance.fetchMovieCredits(movie.id,
            success: { response in
                movie.additionnalInfoLoaded = true
                success()
            },
            failure: failure
        )
    }

}
