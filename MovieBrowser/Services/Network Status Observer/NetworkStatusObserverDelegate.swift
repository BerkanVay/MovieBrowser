//
//  NetworkStatusObserverDelegate.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 16.10.2022.
//

import Foundation

protocol NetworkStatusObserverDelegate: AnyObject {
  func networkStatusChanged()
}
