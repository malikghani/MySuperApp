//
//  FileDownloader.swift
//  MySuperAppEver
//
//  Created by Ghani's Mac Mini on 11/08/2023.
//

import Foundation
class FileDownloader: NSObject, URLSessionDownloadDelegate {

    var onProgress: ((Float) -> Void)?
    var completion: ((Error?) -> Void)?

    private var destinationURL: URL?

    func downloadFile(from url: URL, to destinationURL: URL, onProgress: @escaping (Float) -> Void, completion: @escaping (Error?) -> Void) {
        self.destinationURL = destinationURL
        self.onProgress = onProgress
        self.completion = completion

        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)

        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }

    // URLSessionDownloadDelegate methods
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let destinationURL = destinationURL else {
            return
        }

        do {
            try FileManager.default.moveItem(at: location, to: destinationURL)
            completion?(nil)
        } catch {
            completion?(error)
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        onProgress?(progress)
    }
}
