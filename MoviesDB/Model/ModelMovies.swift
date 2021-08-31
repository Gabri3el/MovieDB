//
//  ModelMovies.swift
//  MoviesDB
//
//  Created by Gabriel on 30/08/21.
//

import Foundation


struct MoviesData: Decodable{
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey{
        case movies = "results"
    }
}

struct Movie: Decodable {
    let title: String
    let year: String
    let rate: Double
    let posterImage: String
    let overview: String
    let vote_count: Int
    let popularity: Double
    
    private enum CodingKeys: String, CodingKey{
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case vote_count
        case popularity
         
    }
}
