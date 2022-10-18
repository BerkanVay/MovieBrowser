//
//  FirebaseLogEventService.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 18.10.2022.
//

import Foundation
import FirebaseAnalytics

class FirebaseLogEventService {
  static func logEvent(eventName: String, eventDescription: String) {
    FirebaseAnalytics.Analytics.logEvent("detail_screen_viewed", parameters: [
      AnalyticsParameterScreenName: "detail_screen_viewed",
      "\(eventName)": "\(eventDescription)"
    ])
  }
}
