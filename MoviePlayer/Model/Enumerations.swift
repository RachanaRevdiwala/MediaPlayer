//
//  Enumerations.swift
//  MoviePlayer
//
//  Created by Devkrushna4 on 13/08/22.
//

import Foundation


enum ClassIdentifier {
    static let movieDetailsViewController       = "MovieDetailsViewController"
}

enum CellIdentifier {
    static let movieDetailTableViewCell         = "MovieDetailTableViewCell"
    static let moviesListTableViewCell          = "MoviesListTableViewCell"
}

struct UserDefaultKeys {
    
    static let userDefaultBearerToken           = "BearerToken"
    static let userDefaultLanguageCode          = "Language_Code"
    static let userDefaultIsLoggedIn            = "isLoggedIn"
    static let userDefaultFirstTimeTheme        = "FirstTimeTheme"
    static let userDefaultAvailabilityStatus    = "AvailabilityStatus"
   
}


struct ResponseKeys {
    static let responseStatus                   = "status"
    static let responseMessage                  = "message"
    static let responseCustomToken              = "customToken"
}


// MARK: - MovieList
struct MovieList: Codable {
    let page: Int
    let totalResults: Int?
    let totalPages: Int?
    let results: [MovieDetail]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults                       = "total_results"
        case totalPages                         = "total_pages"
        case results
    }
}

// MARK: - Result
struct MovieDetail: Codable{
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var posterPath: String?
    var id: Int?
    var adult: Bool?
    var backdropPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIDS: [Int]?
    var title: String?
    var voteAverage: Double?
    var overview, releaseDate: String?

    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount                          = "vote_count"
        case video
        case posterPath                         = "poster_path"
        case id, adult
        case backdropPath                       = "backdrop_path"
        case originalLanguage                   = "original_language"
        case originalTitle                      = "original_title"
        case genreIDS                           = "genre_ids"
        case title
        case voteAverage                        = "vote_average"
        case overview
        case releaseDate                        = "release_date"
    }
}

//MARK: Genre Details
struct GenreList: Codable {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name                           = "name"
    }
    
    
}

