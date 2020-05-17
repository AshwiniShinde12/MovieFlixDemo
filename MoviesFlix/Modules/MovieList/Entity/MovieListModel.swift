

//
//  MovieListModel.swift
//  MoviesFlix
//
//  Created by Ashwini on 16/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import Foundation

struct MoviesModel: Codable {
    var results: [MovieDetails]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct MovieDetails: Codable {

    let posterPath: String
    let id: Int
    let backdropPath: String?
    let title: String
    let overview: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
   
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case overview
        case releaseDate = "release_date"
       
    }
}

