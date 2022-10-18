//
//  SearchTableViewModel.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 16.10.2022.
//

import Foundation


class SearchTableViewModel {
  weak var delegate: SearchTableViewDelegate?
  var searchResultStatus: SearchResultStatus = .dataEmpty {
    didSet {
      delegate?.statusHasChanged()
    }
  }
  private(set) var searchResult: [SearchResponse.Item] = []
  var searchText = "" {
    didSet {
      Task {
        searchResultStatus = .duringFetchData
        searchResult = (try? await RESTClient.getSearchResult(searchWord: searchText))?.items ?? []

        if searchResult.isEmpty {
          searchResultStatus = .dataEmpty
        } else {
          searchResultStatus = .dataFeched
        }
        self.delegate?.reloadData()
      }
    }
  }
  
  enum SearchResultStatus {
    case duringFetchData
    case dataFeched
    case dataEmpty
  }
}
