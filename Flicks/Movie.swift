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
    
    init(from: NSDictionary) {
        title = from["title"] as! String
        rating = from["vote_average"] as! Float
    }
}
