//
//  SearchTableViewModel.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 16.10.2022.
//

import Foundation


class SearchTableViewModel {
  weak var delegate: SearchTableViewDelegate?
  var searchResult: [SearchResponse.Item] = []
  var searchText = "" {
    didSet {
      Task {
        searchResult = (try? await RESTClient.getSearchResult(searchWord: searchText))?.items ?? []
        self.delegate?.reloadData()
      }
    }
  }
}
