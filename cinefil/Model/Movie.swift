//
//  Movie.swift
//  cinefil
//
//  Created by zhou on 2/13/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import SwiftyJSON

func == (lhs: Movie, rhs: Movie) -> Bool{
    return lhs.id == rhs.id
}

struct Movie: Equatable {

    let id: String?
    let title: String?
    let poster: String?
    let backDrop: String?
    let rating: Float
    let releaseDate: String?
    let idGenre: Int

    init(json: JSON) {
        id = json["id"].stringValue
        title = json["title"].stringValue
        poster = json["poster_path"].stringValue
        backDrop = json["backdrop_path"].stringValue
        rating = json["vote_average"].floatValue
        releaseDate = json["release_date"].stringValue
        idGenre = (json["genre_ids"].arrayValue.first?.intValue)!
    }

}
