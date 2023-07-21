//
//  ServiceFactory.swift
//  MySuperApp
//
//  Created by Ghani's Mac Mini on 21/07/2023.
//

import Foundation

struct ServiceFactory {
    static let shared = ServiceFactory()
    
    private init() { }
    
    func generateString() -> String {
        "String from ServiceFactory"
    }
    
    func generateInt() -> Int {
        123456789
    }
}
