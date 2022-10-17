//
//  DetailViewController.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 18.10.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
  @IBOutlet private weak var posterImageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var relasedLabel: UILabel!
  @IBOutlet private weak var countryLabel: UILabel!
  @IBOutlet private weak var languageLabel: UILabel!
  
  var viewModel = DetailViewModel()
  var movieId: String? {
    get {
      viewModel.movieId
    }
    
    set {
      viewModel.movieId = newValue
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    guard let moviewDetail = viewModel.movieDetail else {
      return
    }
    if let url = URL(string: moviewDetail.posterURLString) {
      posterImageView.kf.setImage(with: url)
    }
    titleLabel.text = moviewDetail.title
    relasedLabel.text = moviewDetail.released
    countryLabel.text  = moviewDetail.country
    languageLabel.text = moviewDetail.language
  }
}

extension DetailViewController: DetailViewModelDelegate {
  func reloadData() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }
}
