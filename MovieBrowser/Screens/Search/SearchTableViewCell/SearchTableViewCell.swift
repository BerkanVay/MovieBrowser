//
//  SearchTableViewCell.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 17.10.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var movieTitleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
