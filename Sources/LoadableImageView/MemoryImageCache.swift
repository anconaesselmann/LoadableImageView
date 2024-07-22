//  Created by Axel Ancona Esselmann on 7/22/24.
//

import Foundation

@globalActor
public actor MemoryImageCache: ImageCache {
    public static let shared = MemoryImageCache()

    private var urls: [URL: Data] = [:]

    public func cache(url: URL, data: Data) {
        urls[url] = data
    }

    public func data(for url: URL) -> Data? {
        urls[url]
    }
}
