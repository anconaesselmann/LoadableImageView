//  Created by Axel Ancona Esselmann on 7/22/24.
//

import Foundation

public protocol ImageCache {
    func cache(url: URL, data: Data) async
    func data(for url: URL) async -> Data?
}
