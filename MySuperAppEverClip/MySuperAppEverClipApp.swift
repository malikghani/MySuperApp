//
//  MySuperAppEverClipApp.swift
//  MySuperAppEverClip
//
//  Created by Ghani's Mac Mini on 11/08/2023.
//

import SwiftUI

@main
struct MySuperAppEverClipApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onContinueUserActivity(
                        NSUserActivityTypeBrowsingWeb,
                        perform: handleUserActivity)
        }
        
    }
}

func handleUserActivity(_ userActivity: NSUserActivity) {
    //3
    guard let incomingURL = userActivity.webpageURL, let components = URLComponents(url: incomingURL, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
    return
    }

  //4
  guard
    let name = queryItems.first(where: { $0.name == "name" })?.value
  else {
    return
  }

  //5
  print("name: \(name)")
}
