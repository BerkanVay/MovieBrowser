//
//  SearchTableViewCell.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 17.10.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
  @IBOutlet private weak var movieImageView: UIImageView!
  @IBOutlet private weak var movieTitleLabel: UILabel!
  
  var item: SearchResponse.Item? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    configurate()
  }
  
  private func configurate(){
    guard let item else { return }
    movieTitleLabel.text = item.title
    movieImageView.kf.setImage(with: item.realPosterURL)
  }
}
