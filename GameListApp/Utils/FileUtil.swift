//
//  FileUtil.swift
//  GameListApp
//
//  Created by Erdi Kanık on 5.11.2023.
//

import Foundation

final class FileUtil {

    /// Saves five data of object in document directory
    /// - Parameters:
    ///   - name: File name
    ///   - data: File data
    static func saveFile(by name: String, data: Data) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(name)

        do {
            try data.write(to: url) // Writing an Image in the Documents Directory
        } catch {
            print("Unable to write file")
        }
    }

    /// Get file by name from documents directory
    /// - Parameter name: File name
    /// - Returns: Data if it exists in directory
    static func getFile(by name: String) -> Data? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(name)

        guard let fileData = try? Data(contentsOf: url) else { return nil }

        return fileData
    }
}
