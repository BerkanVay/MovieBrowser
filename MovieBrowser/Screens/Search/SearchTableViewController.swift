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
  var indicator = UIActivityIndicatorView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Search"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.searchController = searchController
    viewModel.delegate = self
    viewModel.searchResultStatus = .dataEmpty
    searchController.searchResultsUpdater = self
    tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    activityIndicator()
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
  func configurateTableViewBackground() {
    DispatchQueue.main.async {
      switch self.viewModel.searchResultStatus {
        
      case .duringFetchData:
        self.tableView.backgroundView = self.indicator
        self.indicator.startAnimating()
      case .dataFeched:
        self.indicator.stopAnimating()
      case .dataEmpty:
        self.indicator.stopAnimating()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
        view.center = self.tableView.center
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
        if self.searchController.searchBar.text == "" {
          label.text = "Pleas write something to search."
        } else {
          label.text = "No results were found."
        }
        label.center = view.center
        label.textAlignment = .center
        label.textColor = .black
        view.addSubview(label)
        self.tableView.backgroundView = view
        self.reloadData()
      }
    }
  }
  
  func activityIndicator() {
    DispatchQueue.main.async {
      
      self.indicator.hidesWhenStopped = true
      self.indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
      self.indicator.center = self.view.center
      self.tableView.addSubview(self.indicator)
    }
  }
  
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
