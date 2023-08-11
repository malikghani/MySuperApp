//
//  ODRManager.swift
//  MySuperAppEver
//
//  Created by Ghani's Mac Mini on 11/08/2023.
//

import Foundation

final class ODRManager {

    static let shared = ODRManager()
    
    var currentRequest: NSBundleResourceRequest?
    
    func requestAssetWith(tag: String, onSuccess: @escaping () -> Void, onFailure: @escaping (NSError) -> Void) {
        currentRequest = NSBundleResourceRequest(tags: [tag])

        guard let request = currentRequest else { return }

        request.beginAccessingResources { error in
            if let error = error {
                onFailure(error as NSError)
                return
            }

            onSuccess()
        }
    }
}
