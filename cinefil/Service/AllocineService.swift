//
//  AllocineService.swift
//  cinefil
//
//  Created by zhou on 2/13/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// https://wiki.gromez.fr/dev/api/allocine_v3
class AllocineService {

    enum Service: String {
        case MovieList = "/movielist"
        case TheaterList = "theaterlist"
    }

    static let instance = AllocineService()

    let baseUrl = "http://api.allocine.fr/rest/v3"
    let dateFormatter = NSDateFormatter()

    func baserequest(url: String, success: (JSON -> Void), failure: (ServiceError -> Void)) {
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    success(JSON(value))
                }
            case .Failure(let error):
                failure(ServiceError(error: error.description))
            }
        }
    }

    // param order matter,
    func fetchMovies(params: [(String, String)], success: (JSON -> Void), failure: (ServiceError -> Void)) {
        let privateKey = [
            ("partner", AllocineKey.partnerKey),
            ("code", AllocineKey.partnerCode),
            ("format", "json"),
        ]
        let requestParams = privateKey + params + [("sed", sedKey())]
        let paramString = requestParams.map( { "\($0.0)=\($0.1)" } ).joinWithSeparator("&")
        let sig = sigKey(paramString)
        let urlString = baseUrl + Service.MovieList.rawValue + "?" + paramString + "&sig=\(sig)"

        baserequest(urlString, success: success, failure: failure)
    }

    func fetchShowTimeList(params: [(String, String)], success: (JSON -> Void), failure: (ServiceError -> Void)) {
        let privateKey = [
            ("partner", AllocineKey.partnerKey),
            ("format", "json"),
        ]

        let requestParams = privateKey + params + [("sed", sedKey())]
        let paramString = requestParams.map( { "\($0.0)=\($0.1)" } ).joinWithSeparator("&")
        let sig = sigKey(paramString)
        let urlString = baseUrl + "/showtimelist" + "?" + paramString + "&sig=\(sig)"

        print(urlString)
        baserequest(urlString, success: success, failure: failure)
    }

    //http://api.allocine.fr/rest/v3/showtimelist?partner=100043982026&format=json&theaters=C0159&date=2016-03-11&count=10&page=1&sed=20160311&sig=NuOaobPuTcsMgYrRWVb3w6S2dnA%3D

    func sedKey() -> String {
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.stringFromDate(NSDate())
    }

    func sigKey(paramString: String) -> String {
        let customAllowedSet =  NSCharacterSet(charactersInString:"=\"#%/<>?@\\^`{|}").invertedSet
        let input = AllocineKey.requestKey + paramString
        let sha1 = input.sha1Encode()

        return sha1.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
    }

}
