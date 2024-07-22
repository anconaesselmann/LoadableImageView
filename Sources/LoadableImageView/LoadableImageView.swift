//  Created by Axel Ancona Esselmann on 7/22/24.
//

import SwiftUI
import LoadableView

public struct LoadableImageView: IDedDefaultLoadableView {

    public let id: URL

    public init(url: URL, cache: ImageCache? = MemoryImageCache.shared) {
        self.id = url
        self._vm = StateObject(wrappedValue: LoadableImageViewModel(cache: cache))
    }

    @StateObject
    public var vm: LoadableImageViewModel

    public func loaded(_ viewData: Data) -> some View {
    #if canImport(UIKit)
        let songArtwork: UIImage = UIImage(data: viewData) ?? UIImage()
        let image = Image(uiImage: songArtwork)
    #elseif canImport(AppKit)
        let songArtwork: NSImage = NSImage(data: viewData) ?? NSImage()
        let image = Image(nsImage: songArtwork)
    #else
        let image = Image(systemImage: "photo")
    #endif
        return image.resizable().scaledToFit()
    }
}

@MainActor
public final class LoadableImageViewModel: IDedLoadableViewModel {

    public var id: URL?

    @Published
    public var viewState: ViewState<Data> = .notLoaded

    private var cache: ImageCache?

    public init(cache: ImageCache?) {
        self.cache = cache
    }

    public var overlayState: OverlayState = .none

    public func load(id url: URL) async throws -> Data {
        if let data = await cache?.data(for: url) {
            return data
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        await cache?.cache(url: url, data: data)
        return data
    }
}
