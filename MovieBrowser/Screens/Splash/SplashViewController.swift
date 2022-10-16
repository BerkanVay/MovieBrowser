//
//  SplashViewController.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 15.10.2022.
//

import UIKit
import Network

class SplashViewController: UIViewController {
  @IBOutlet private weak var welcomingTextLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    FirebaseRemoteConfigService.shared.delegate = self
    
    fetchedRemoteConfig()
  }
}

extension SplashViewController: FirebaseRemoteConfigDelegate {
  func fetchedRemoteConfig() {
    DispatchQueue.main.async {
      if FirebaseRemoteConfigService.shared.isFetched {
        self.welcomingTextLabel.text = FirebaseRemoteConfigService.shared.splashText
      } else {
        self.welcomingTextLabel.text = "Loading..."
      }
    }
  }
}
