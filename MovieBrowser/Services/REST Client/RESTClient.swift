//
//  RESTClient.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 15.10.2022.
//

import Foundation

class RESTClient {
  private static let baseURLString = "https://www.omdbapi.com"
  private static let apiKey = "6c2b857"
  
  enum NetworkingError: Error {
    case invalidURL
  }
  
  private static let jsonDecoder = JSONDecoder()
  
  static func getSearchResult(searchWord: String) async throws -> SearchResponse {
    try await doRequest(withEndpoint: "/", queryParameters: ["s" : searchWord])
  }
  
  static func getFilmResult(imdbID: String) async throws -> FilmResponse {
    try await doRequest(withEndpoint: "/", queryParameters: ["i" : imdbID])
  }
  
  private static func doRequest<T: Decodable>(withEndpoint endpoint: String, queryParameters: [String: String]) async throws -> T {
    guard var urlComponents = URLComponents(string: baseURLString) else {
      throw NetworkingError.invalidURL
    }
    
    urlComponents.path = endpoint
    
    urlComponents.queryItems = queryParameters.map { (key, value) in
      URLQueryItem(name: key, value: value)
    }
    
    urlComponents.queryItems?.append(URLQueryItem(name: "apikey", value: apiKey))
    
    guard let url = urlComponents.url else {
      throw NetworkingError.invalidURL
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    
    return try jsonDecoder.decode(T.self, from: data)
  }
}
