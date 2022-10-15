//
//  FirebaseRemoteConfig.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 15.10.2022.
//

import Foundation
import FirebaseRemoteConfig

class FirebaseRemoteConfigService {
  weak var delegate: FirebaseRemoteConfigDelegate?
  
  var splashText: String? {
    remoteConfig.configValue(forKey: "splash_text").stringValue
  }
  
  private var remoteConfig = RemoteConfig.remoteConfig()
  
  init() {
    configureRemoteConfig()
    
    Task {
      await fetch()
    }
  }
  
  private func configureRemoteConfig() {
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0
    
    remoteConfig.configSettings = settings
  }
  
  private func fetch() async {
    do {
      let status = try await remoteConfig.fetchAndActivate()
      
      if status != .successFetchedFromRemote && status != .successUsingPreFetchedData {
        print("Failed to fetch. Status: \(status)")
      } else {
        delegate?.fetchedRemoteConfig()
      }
    } catch {
      // TODO: Handle the error.
      print(error)
    }
  }
}

