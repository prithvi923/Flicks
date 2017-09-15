//
//  Movie.swift
//  Flicks
//
//  Created by Prithvi Prabahar on 9/11/17.
//  Copyright © 2017 Prithvi Prabahar. All rights reserved.
//

import Foundation

class Movie {
    
    var title: String
    var rating: Float
    var backdropPath: String
    var posterPath: String
    var overview: String
    
    init(from: NSDictionary) {
        title = from["title"] as! String
        rating = from["vote_average"] as! Float
        backdropPath = from["backdrop_path"] as? String ?? from["poster_path"] as! String
        posterPath = from["poster_path"] as! String
        overview = from["overview"] as! String
    }
}
