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

class Movie: Equatable {

    let id: String
    let title: String
    let poster: String
    let backDrop: String
    let rating: Float
    let releaseDate: String
    var genres: [Genre]

    // extended informations
    var additionnalInfoLoaded = false
    var overView: String?

    init(json: JSON) {
        id = json["id"].stringValue
        title = json["title"].stringValue
        poster = json["poster_path"].stringValue
        backDrop = json["backdrop_path"].stringValue
        rating = json["vote_average"].floatValue
        releaseDate = json["release_date"].stringValue
        genres = []
/*        for row in json["genre_ids"].arrayValue {
            genres.append(row.stringValue)
        }*/
        overView = json["overView"].stringValue
    }

    init(allocine: JSON) {
        id = allocine["code"].stringValue
        title = allocine["originalTitle"].stringValue
        releaseDate = allocine["release"]["releaseDate"].stringValue
        genres = []
        for row in allocine["genre"].arrayValue {
            let genre = Genre(id: row["code"].stringValue, value: row["$"].stringValue)
            genres.append(genre)
        }
        poster = allocine["poster"]["href"].stringValue
        overView = allocine["synopsisShort"].stringValue
        backDrop = allocine["defaultMedia"]["media"]["thumbnail"]["href"].stringValue
        rating = allocine["statistics"]["userRating"].floatValue
    }

    func getGenreString() -> String {
        return genres.map( { $0.name } ).joinWithSeparator(", ")
    }

    func loadAdditionnalInformations(json: JSON) {

    }

}
