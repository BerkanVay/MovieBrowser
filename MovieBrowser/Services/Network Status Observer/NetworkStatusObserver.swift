//
//  NetworkStatusObserver.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 16.10.2022.
//

import Foundation
import Network

class NetworkStatusObserver {
  static let shared = NetworkStatusObserver()
  
  weak var delegate: NetworkStatusObserverDelegate?
  var isNetworkAvailable: Bool {
    didSet {
      if oldValue != isNetworkAvailable {
        delegate?.networkStatusChanged()
      }
    }
  }
  
  private let monitor = NWPathMonitor()
  
  private init() {
    isNetworkAvailable = monitor.currentPath.status == .satisfied
    
    monitor.pathUpdateHandler = { [weak self] path in
      guard let self else { return }
      
      self.isNetworkAvailable = path.status == .satisfied
    }
    
    monitor.start(queue: .global(qos: .userInteractive))
  }
}
