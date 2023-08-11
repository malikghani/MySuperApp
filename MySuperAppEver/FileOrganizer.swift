//
//  FileOrganizer.swift
//  MySuperAppEver
//
//  Created by Ghani's Mac Mini on 11/08/2023.
//

import Foundation

final class FileOrganizer {
    static var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    static func readFile(for fileName: String) -> URL? {
        guard let fileURL = documentDirectory?.appendingPathComponent(fileName) else {
            return nil
        }
        
        if let _ = FileManager.default.contents(atPath: fileURL.path) {
            return fileURL
        }
        
        return nil
    }
    
    static func saveFile(from url: URL, fileName: String) {
        guard let fileURL = documentDirectory?.appendingPathComponent(fileName) else {
            return
        }
        
        guard let fileData = try? Data(contentsOf: url) else {
            return
        }
        
        do {
            try fileData.write(to: fileURL)
            print("Success write to document directory.")
        } catch {
            print(error)
        }
    }
    
    static func deleteFile(for fileName: String) {
        guard let fileURLToDelete = documentDirectory?.appendingPathComponent(fileName) else {
            return
        }

        do {
            try FileManager.default.removeItem(at: fileURLToDelete)
            print("File deleted successfully.")
        } catch {
            print("Error deleting file: \(error)")
        }
    }
}
