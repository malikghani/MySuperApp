//
//  ListView.swift
//  MySuperAppEver
//
//  Created by Ghani's Mac Mini on 21/07/2023.
//

import SwiftUI

struct ListModalView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Text("This gonna be my super app 🚀")
                
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}
