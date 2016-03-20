//
//  WebService.swift
//  cinefil
//
//  Created by zhou on 2/13/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import Alamofire
import SwiftyJSON

class MovieDBService {

    enum Service: String {
        case TopRatedMovies = "/movie/top_rated"
        case PopularMovies = "/movie/popular"
        case NowPlaying = "/movie/now_playing"
        case MovieGenres = "/genre/movie/list"
    }

    enum ImageSize: String {
        case Small = "w300"
        case Normal = "w780"
        case Big = "w1280"
        case Original = "original"
    }

    static let instance = MovieDBService()

    // MovieDB links
    let baseUrl = "https://api.themoviedb.org/3"
    let imageBaseUrl = "https://image.tmdb.org/t/p/"
    var apiKey = ""

    init() {
        apiKey = FileManager.getApiKey("TheMovieDB")
    }

    func baseRequest(url: String, success: (JSON -> Void), failure: (NSError -> Void)) {
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    success(JSON(value))
                }
            case .Failure(let error):
                failure(error)
            }
        }
    }

    // MARK: - Movie

    func fetchMovies(service: Service, success: ([Movie] -> Void), failure: (ServiceError -> Void)) {
        let url = baseUrl + service.rawValue + "?api_key=\(apiKey)"

        baseRequest(url,
            success: { response in
                var movies: [Movie] = []
                for movie in response["results"].arrayValue {
                    movies.append(Movie(json: movie))
                }
                success(movies)
            },
            failure: { (error) -> Void in
                failure(ServiceError(error: error.description))
            }
        )
    }

    // MARK: - Images

    func imageUrl(size: ImageSize, name: String) -> NSURL? {
        let urlString = imageBaseUrl + "/\(size.rawValue)/" + name
        if let url = NSURL(string: urlString) {
            return url
        }
        return nil
    }

    // MARK: - Genres

    func fetchtMovieGenres(success: ([String: Genre] -> Void), failure: (ServiceError -> Void)) {
        let url = baseUrl + "/genre/movie/list?api_key=\(apiKey)"
        baseRequest(url,
            success: { response in
                var genres: [String: Genre] = Dictionary()
                for row in response["genres"].arrayValue {
                    let genre = Genre(json: row)
                    genres[genre.id] = genre
                }
                success(genres)
            },
            failure: { (error) -> Void in
                failure(ServiceError(error: error.description))
            }
        )
    }

    // MARK: - Persons

    func fetchMovieCredits(movieId: String, success: (JSON -> Void), failure: (ServiceError -> Void)) {
        let url = baseUrl + "/movie/\(movieId)/credits?api_key=\(apiKey)"
        baseRequest(url,
            success: { response in
                success(response)
            },
            failure: { error in
                failure(ServiceError(error: error.description))
            }
        )
    }

}
