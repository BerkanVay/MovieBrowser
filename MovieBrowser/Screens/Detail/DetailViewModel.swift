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
        FirebaseLogEventService.logEvent(eventName: "detail_screen_viewed", eventDetailName: "title", eventDescription: movieDetail.title)
        FirebaseLogEventService.logEvent(eventName: "detail_screen_viewed", eventDetailName: "released_date", eventDescription: movieDetail.released)
        FirebaseLogEventService.logEvent(eventName: "detail_screen_viewed", eventDetailName: "country", eventDescription: movieDetail.country)
        FirebaseLogEventService.logEvent(eventName: "detail_screen_viewed", eventDetailName: "language", eventDescription: movieDetail.country)
      }
    }
  }
}
