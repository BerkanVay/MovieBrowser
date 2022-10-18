//
//  DetailViewModel.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 18.10.2022.
//

import Foundation

class DetailViewModel {
  
  weak var delegate: DetailViewModelDelegate?
  
  var movieDetail: FilmResponse? {
    didSet {
      delegate?.reloadMovieData()
    }
  }
  
  var movieId: String? {
    didSet {
      guard let movieId else { return }
      Task {
        movieDetail = (try? await RESTClient.getFilmResult(imdbID: movieId))
        guard let movieDetail else { return }
        FirebaseLogEventService.logEvent(eventName: "title", eventDescription: movieDetail.title)
        FirebaseLogEventService.logEvent(eventName: "released_date", eventDescription: movieDetail.released)
        FirebaseLogEventService.logEvent(eventName: "country", eventDescription: movieDetail.country)
        FirebaseLogEventService.logEvent(eventName: "language", eventDescription: movieDetail.country)
      }
    }
  }
}
