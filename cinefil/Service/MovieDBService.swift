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
        case MovieGenres = "/genre/movie/list"
    }

    enum ImageSize: String {
        case Small = "w300"
        case Normal = "w780"
        case Big = "w1280"
        case Original = "original"
    }

    static let instance = MovieDBService()

    let baseUrl = "https://api.themoviedb.org/3"
    let imageBaseUrl = "https://image.tmdb.org/t/p/"
    var apiKey = ""

    init() {
        apiKey = FileManager.getApiKey("TheMovieDB")
    }

    func baseRequest(service: Service, success: (JSON -> Void), failure: (NSError -> Void)) {
        let url = baseUrl + service.rawValue + "?api_key=\(apiKey)"

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

    func imageUrl(size: ImageSize, name: String) -> NSURL? {
        let urlString = imageBaseUrl + "/\(size.rawValue)/" + name
        if let url = NSURL(string: urlString) {
            return url
        }
        return nil
    }

}
