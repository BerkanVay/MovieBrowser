//
//  FirebaseLogEventService.swift
//  MovieBrowser
//
//  Created by Mustafa Berkan Vay on 18.10.2022.
//

import Foundation
import FirebaseAnalytics

class FirebaseLogEventService {
  static func logEvent(eventName: String, eventDetailName: String, eventDescription: String) {
    FirebaseAnalytics.Analytics.logEvent(eventName, parameters: [
      AnalyticsParameterScreenName: eventName,
      eventDetailName : eventDescription
    ])
  }
}
