//
//  FirebaseRemoteConfigService.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 15.10.2022.
//

import Foundation
import FirebaseRemoteConfig

class FirebaseRemoteConfigService {
  static let shared = FirebaseRemoteConfigService()
  weak var delegate: FirebaseRemoteConfigServiceDelegate?
  
  var splashText: String? {
    remoteConfig.configValue(forKey: "splash_text").stringValue
  }
  var isFetched = false {
    didSet {
      if isFetched {
        delegate?.fetchedRemoteConfig()
      }
    }
  }
  private var remoteConfig = RemoteConfig.remoteConfig()
  
  private init() {
    configureRemoteConfig()
    
    Task {
      await fetch()
    }
  }
  
  func fetch() async {
    do {
      let status = try await remoteConfig.fetchAndActivate()
      
      if status != .successFetchedFromRemote && status != .successUsingPreFetchedData {
        print("Failed to fetch. Status: \(status)")
      } else {
        isFetched = true
      }
    } catch {
      // TODO: Handle the error.
      print(error)
    }
  }
  
  private func configureRemoteConfig() {
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0
    
    remoteConfig.configSettings = settings
  }
}
