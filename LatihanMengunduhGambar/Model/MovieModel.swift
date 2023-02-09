//
//  MovieModel.swift
//  LatihanMengunduhGambar
//
//  Created by Ade Fajr Ariav on 06/02/23.
//

import UIKit

enum DownloadState {
    case new, downloaded, failed
}

class Movie {
    let title: String
    let popularity: Double
    let genres: [Int]
    let voteAverage: Double
    let overview: String
    let releaseDate: Date
    let posterPath: URL
    
    var image: UIImage?
    var state: DownloadState = .new
    
    init(title: String,
         popularity: Double,
         genres: [Int],
         voteAverage: Double,
         overview: String,
         releaseDate: Date,
         posterPath: URL) {
        self.title = title
        self.popularity = popularity
        self.genres = genres
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterPath = posterPath
    }
}


struct MovieResponses: Codable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let movies: [MovieResponse]
 
  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case movies = "results"
  }
}
 
struct MovieResponse: Codable {
  let popularity: Double
  let title: String
  let genres: [Int]
  let voteAverage: Double
  let overview: String
  let releaseDate: Date
 
  let posterPath: URL
 
  enum CodingKeys: String, CodingKey {
    case popularity
    case posterPath = "poster_path"
    case title
    case genres = "genre_ids"
    case voteAverage = "vote_average"
    case overview
    case releaseDate = "release_date"
  }
 
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
 
    // Menentukan alamat gambar
    let path = try container.decode(String.self, forKey: .posterPath)
    posterPath = URL(string: "https://image.tmdb.org/t/p/w300\(path)")!
 
    // Menentukan tanggal rilis
    let dateString = try container.decode(String.self, forKey: .releaseDate)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    releaseDate = dateFormatter.date(from: dateString)!
 
    // Untuk properti lainnya, cukup disesuaikan saja.
    popularity = try container.decode(Double.self, forKey: .popularity)
    title = try container.decode(String.self, forKey: .title)
    genres = try container.decode([Int].self, forKey: .genres)
    voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    overview = try container.decode(String.self, forKey: .overview)
  }
}


//let movies = [
//    Movie(
//        title: "Thor: Love and Thunder",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")!
//    ), Movie(
//        title: "Minions: The Rise of Gru",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg")!
//    ), Movie(
//        title: "Jurassic World Dominion",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg")!
//    ), Movie(
//        title: "Top Gun: Maverick",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg")!
//    ), Movie(
//        title: "The Gray Man",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/8cXbitsS6dWQ5gfMTZdorpAAzEH.jpg")!
//    ), Movie(
//        title: "The Black Phone",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/p9ZUzCyy9wRTDuuQexkQ78R2BgF.jpg")!
//    ), Movie(
//        title: "Lightyear",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/ox4goZd956BxqJH6iLwhWPL9ct4.jpg")!
//    ), Movie(
//        title: "Doctor Strange in the Multiverse of Madness",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg")!
//    ), Movie(
//        title: "Indemnity",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/tVbO8EAbegVtVkrl8wNhzoxS84N.jpg")!
//    ), Movie(
//        title: "Borrego",
//        poster: URL(string: "https://image.tmdb.org/t/p/w500/kPzQtr5LTheO0mBodIeAXHgthYX.jpg")!
//    )
//]
