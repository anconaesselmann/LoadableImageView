//  Created by Axel Ancona Esselmann on 7/25/24.
//

import Foundation
import CryptoKit

@globalActor
public actor DiscImageCache: ImageCache {
    public static let shared = DiscImageCache()

    static var cacheDir: URL? {
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appending(path: "image_cache")
    }

    public init() {
        guard let cacheDir = Self.cacheDir else {
            return
        }
        try? FileManager.default.createDirectory(at: cacheDir, withIntermediateDirectories: true)
    }


    private static func hash(url: URL) -> String {
        let data = Data(url.absoluteString.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }

    private static func localUrl(for imageUrl: URL) -> URL? {
        let hash = Self.hash(url: imageUrl)
        return Self.cacheDir?.appending(path: hash)
    }

    public func cache(url: URL, data: Data) {
        guard let localUrl = Self.localUrl(for: url) else {
            return
        }
        try? data.write(to: localUrl)
    }

    public func data(for url: URL) -> Data? {
        guard let localUrl = Self.localUrl(for: url) else {
            return nil
        }
        return try? Data(contentsOf: localUrl)
    }
}
