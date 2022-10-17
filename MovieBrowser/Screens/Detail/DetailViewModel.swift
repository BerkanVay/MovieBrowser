//
//  DetailViewModel.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 18.10.2022.
//

import Foundation

class DetailViewModel {
  
  weak var delegate: DetailViewModelDelegate?
  
  var movieDetail: FilmResponse?
  
  var movieId: String? {
    didSet {
      guard let movieId else { return }
      Task {
        movieDetail = (try? await RESTClient.getFilmResult(imdbID: movieId))
        self.delegate?.reloadData()
      }
    }
  }
}

