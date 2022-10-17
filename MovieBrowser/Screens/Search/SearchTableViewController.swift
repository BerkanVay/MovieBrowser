//
//  SearchTableViewController.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 16.10.2022.
//

import UIKit
import Kingfisher

class SearchTableViewController: UITableViewController {
  
  private let searchController = UISearchController()
  var viewModel = SearchTableViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Search"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.searchController = searchController
    viewModel.delegate = self
    searchController.searchResultsUpdater = self
    tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
  }
}

extension SearchTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.searchResult.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell else {
      return UITableViewCell()
    }
    let searchResponseItem = viewModel.searchResult[indexPath.row]
    cell.movieTitleLabel.text = searchResponseItem.title
    if let url = URL(string: searchResponseItem.posterURLString){
      cell.movieImageView.kf.setImage(with: url)
    }
    
    return cell
  }
}

extension SearchTableViewController: SearchTableViewDelegate {
  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

extension SearchTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else {
      return
    }
    viewModel.searchText = searchText
  }
}
