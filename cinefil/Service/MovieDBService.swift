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
        case PopularMovies = "/movie/Popular"
    }

    static let instance = MovieDBService()

    let baseUrl = "https://api.themoviedb.org/3"
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

}
