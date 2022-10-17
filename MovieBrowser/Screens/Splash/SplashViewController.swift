//
//  SplashViewController.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 15.10.2022.
//

import UIKit

class SplashViewController: UIViewController {
  @IBOutlet private weak var welcomingTextLabel: UILabel!
  
  private var hasHandledNavigationOnce = false
  private var alert: UIAlertController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NetworkStatusObserver.shared.delegate = self
    FirebaseRemoteConfigService.shared.delegate = self
    
    fetchedRemoteConfig()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    networkStatusChanged()
  }
}

extension SplashViewController: NetworkStatusObserverDelegate {
  func networkStatusChanged() {
    DispatchQueue.main.async {
      if NetworkStatusObserver.shared.isNetworkAvailable {
        self.alert?.dismiss(animated: true)
        self.alert = nil
        
        Task {
          try await Task.sleep(nanoseconds: 1_000_000_000)
          
          await FirebaseRemoteConfigService.shared.fetch()
        }
      } else {
        let alert = UIAlertController(title: "No internet connection.", message: "Pleas make sure you are connected to internet.", preferredStyle: .alert)
        self.present(alert, animated: true)
        self.alert = alert
      }
    }
  }
}

extension SplashViewController: FirebaseRemoteConfigServiceDelegate {
  func fetchedRemoteConfig() {
    DispatchQueue.main.async {
      if FirebaseRemoteConfigService.shared.isFetched {
        guard !self.hasHandledNavigationOnce else { return }
        
        self.welcomingTextLabel.text = FirebaseRemoteConfigService.shared.splashText
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
          self.performSegue(withIdentifier: "showSearch", sender: nil)
        }
        
        self.hasHandledNavigationOnce = true
      } else {
        self.welcomingTextLabel.text = "Loading..."
      }
    }
  }
}


