import SwiftUI

/// Manages photos being persisted to disk using FileManager, Singleton usage
final class ImageCacheFileManager {
    
    // MARK: - Properties

    static let shared = ImageCacheFileManager()
    
    // MARK: - Init

    private init() {
        createFolderIfNeeded()
    }
    
    // MARK: - Methods
    
    func add(key: String, image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5),
              let url = getImagePath(key: key) else {
                  return
              }
        do {
            try data.write(to: url)
        } catch let error {
            log("Error writing url to disk: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard let url = getImagePath(key: key),
              FileManager.default.fileExists(atPath: url.path) else {
                  return nil
              }
        return UIImage(contentsOfFile: url.path)
    }
    
}

// MARK: - Private Method Extensions

extension ImageCacheFileManager {
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(key + Constants.jpg)
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch let error {
                log("Error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager.default.urls(for: .cachesDirectory,
                                        in: .userDomainMask).first?.appendingPathComponent(Constants.catsFolder)
    }
    
}
