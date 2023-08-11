//
//  WButton.swift
//  MySuperAppEver
//
//  Created by Ghani's Mac Mini on 11/08/2023.
//

import SwiftUI

struct WButton: View {
    @Binding var title: String
    var backgroundColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .clipShape(Capsule())
        }
    }
}
