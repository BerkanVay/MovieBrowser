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
  
  private let viewModel = DetailViewModel()
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
    reloadMovieData()
  }
}

extension DetailViewController: DetailViewModelDelegate {
  func reloadMovieData() {
    configurate()
  }
}

extension DetailViewController {
  private func configurate() {
    DispatchQueue.main.async {
      self.posterImageView.kf.setImage(with: self.viewModel.movieDetail?.realPosterURL)
      self.titleLabel.text = self.viewModel.movieDetail?.title
      self.relasedLabel.text = self.viewModel.movieDetail?.released
      self.countryLabel.text  = self.viewModel.movieDetail?.country
      self.languageLabel.text = self.viewModel.movieDetail?.language
    }
  }
}

