//
//  SearchResponse.swift
//  FilmBrowser
//
//  Created by Mustafa Berkan Vay on 15.10.2022.
//

import Foundation

struct SearchResponse: Decodable {
  let items: [Item]
  
  enum CodingKeys: String, CodingKey {
    case items = "Search"
  }
  
  struct Item: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let posterURLString: String
    
    enum CodingKeys: String, CodingKey {
      case title = "Title"
      case year = "Year"
      case imdbID
      case type = "Type"
      case posterURLString = "Poster"
    }
  }
}
