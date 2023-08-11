//
//  MainView.swift
//  MySuperApp
//
//  Created by Ghani's Mac Mini on 21/07/2023.
//

import SwiftUI
import AVKit
import AVFoundation

struct MainView: View {
    @State private var isPresented = false
    @State private var videoURL = URL(string: "")
    
    var body: some View {
        VStack(spacing: 0) {
            Image("top")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .clipped()

            Spacer()

            ZStack {
                VStack {
                    Text("Main App")
                            .font(.system(size: 36, weight: .bold))
                    
                    WButton(title: .constant("Play Video"), backgroundColor: .blue) {
                        if let fileURL = FileOrganizer.readFile(for: "example-video.mp4") {
                            print("play from document")
                            videoURL = fileURL
                            isPresented.toggle()
                        } else {
                            print("download the odr")
                            downloadFromODR()
                        }
                    }
                    
                    WButton(title: .constant("Delete File"), backgroundColor: .red) {
                        FileOrganizer.deleteFile(for: "example-video.mp4")
                    }
                }

                if isPresented {
                    VStack {
                        AVPlayerView(videoURL: $videoURL)
                            .transition(.move(edge: .bottom))
                            .edgesIgnoringSafeArea(.all)
                        
                        WButton(title: .constant("Close"), backgroundColor: .blue) {
                            isPresented = false
                        }
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            Image("bottom")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .clipped()
        }
        .edgesIgnoringSafeArea(.all)
        .background(
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.3)
                .blur(radius: 5)
        )
    }
    
    private func downloadFromODR() {
        ODRManager.shared.requestAssetWith(tag: "example-video") {
            print("Requesting ODR done.")
            
            guard let url = ODRManager.shared.currentRequest?.bundle.url(forResource: "example-video", withExtension: "mp4") else {
                return
            }
            
            FileOrganizer.saveFile(from: url, fileName: "example-video.mp4")
           
            videoURL = url
            isPresented.toggle()
        } onFailure: { error in
            print(error)
        }
    }
}
