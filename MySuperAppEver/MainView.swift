//
//  MainView.swift
//  MySuperApp
//
//  Created by Ghani's Mac Mini on 21/07/2023.
//

import SwiftUI

struct MainView: View {
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            Button("Present List Modal") {
                isPresented.toggle()
            }
            .tint(.blue)
            .fullScreenCover(isPresented: $isPresented, content: ListModalView.init)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
