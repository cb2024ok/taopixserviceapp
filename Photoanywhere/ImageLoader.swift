//
//  ImageLoader.swift
//  TESTUI
//
//  Created by baby Enjhon on 2020/07/20.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

// MARK: -- NSCache 캐시 프로토콜을 이용
protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as URL as NSURL)
        }
        
        set {
            newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as URL as NSURL)
        }
    }
}


class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var cancellable: AnyCancellable?
    
    private let url: URL
    private var cache: ImageCache?
    
    // Loading State
    private (set) var isLoading = false
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    func load() {
        
        guard !isLoading else { return }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue)
            .map({ UIImage(data: $0.data)})
        .replaceError(with: nil)
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.onStart()},
               receiveOutput: { [weak self] in self?.cache($0) },
               receiveCompletion: { [weak self] _ in self?.onFinish() },
               receiveCancel: { [weak self] in self?.onFinish() }
            )
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func cache(_ image: UIImage?) {
        image.map {
            cache?[url] = $0
        }
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
}
