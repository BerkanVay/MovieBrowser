//
//  FilmResponse.swift
//  FilmBrowser
//
//  Created by Mustafa Berkan Vay on 15.10.2022.
//

import Foundation

struct FilmResponse: Decodable {
  let title: String
  let year: String
  let released: String
  let runtime: String
  let genre: String
  let director: String
  let country: String
  let language: String
  let awards: String
  let posterURLString: String
  let imdbRating: String
  let imdbVotes: String
  let type: String
  var realPosterURL: URL {
    if posterURLString == "N/A" {
      return URL(string: "https://icon-library.com/images/no-image-icon/no-image-icon-5.jpg")!
    } else {
      return URL(string: posterURLString)!
    }
  }
  enum CodingKeys: String, CodingKey {
    case title = "Title"
    case year = "Year"
    case released = "Released"
    case runtime = "Runtime"
    case genre = "Genre"
    case director = "Director"
    case country = "Country"
    case language = "Language"
    case awards = "Awards"
    case posterURLString = "Poster"
    case imdbRating
    case imdbVotes
    case type = "Type"
  }
}
