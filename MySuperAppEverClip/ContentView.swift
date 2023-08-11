//
//  ContentView.swift
//  MySuperAppEverClip
//
//  Created by Ghani's Mac Mini on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    
    @State private var videoURL = URL(string: "")
    @State private var onDownloading = false
    
    @State private var playTitle = "Play Video"
    
    private var videoDownload = URL(string: "https://malikghani.com/example-video.mp4")!
    private var saveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("example-video.mp4")
    
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
                    Text("App Clip")
                        .font(.system(size: 36, weight: .bold))
                    
                    HStack(spacing: 4) {
                        WButton(title: $playTitle, backgroundColor: .blue) {
                            if let fileURL = FileOrganizer.readFile(for: "example-video.mp4") {
                                print("play from document")
                                videoURL = fileURL
                                isPresented.toggle()
                            } else {
                                print("download from url")
                                downloadFile(from: videoDownload, to: saveURL, onDownloadProgress: { progress in
                                    self.onDownloading = true
                                    let progress = String(format: "%.2f", progress)
                                    playTitle = "Downloading file \(progress)%"
                                }) { error in
                                    if let fileURL = FileOrganizer.readFile(for: "example-video.mp4") {
                                        print("play from document")
                                        videoURL = fileURL
                                        isPresented.toggle()
                                        onDownloading = false
                                        playTitle = "Play Video"
                                    }
                                }
                            }
                        }
                        .disabled(onDownloading)
                    }
       
                    WButton(title: .constant("Delete File"), backgroundColor: .red) {
                        FileOrganizer.deleteFile(for: "example-video.mp4")
                    }
                }
                .padding(.horizontal)
                
                if isPresented {
                    VStack {
                        AVPlayerView(videoURL: $videoURL).transition(.move(edge: .bottom)).edgesIgnoringSafeArea(.all)
                        
                        WButton(title: .constant("Close"), backgroundColor: .blue) {
                            isPresented = false
                        }
                    }
                }
            }

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
    
    func downloadFile(from sourceURL: URL, to destinationURL: URL, onDownloadProgress: @escaping (Float) -> Void, completion: @escaping (Error?) -> Void) {
        let fileDownloader = FileDownloader()
        fileDownloader.downloadFile(from: sourceURL, to: destinationURL, onProgress: { progress in
                                        let progress = progress * 100
                                        onDownloadProgress(progress)
                                    }) { error in
                                        if let error = error {
                                            print("Error downloading file: \(error)")
                                            completion(error)
                                        } else {
                                            print("File downloaded successfully to \(destinationURL)")
                                            completion(nil)
                                        }
                                    }
    }
}
