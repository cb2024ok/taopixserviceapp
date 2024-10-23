//
//  ImageView.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/20.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    private let configuration: (Image) -> Image
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    
    
    init(url: URL, placeholder: Placeholder? = nil, cache: ImageCache? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
        print(url)
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = placeholder
        self.configuration = configuration
    }
    
    private var image: some View {
        Group {
                if loader.image != nil {
                    configuration(Image(uiImage: loader.image!) )
                } else {
                       placeholder
                }
            }
    }
    
    var body: some View {
        
        image.onAppear {
            self.loader.load()
        }
        .onDisappear {
            self.loader.cancel()
        }
    }
    
}

struct ImageCacheKey: EnvironmentKey {
    
    static var defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache  {
        get {
            self[ImageCacheKey.self]
        }
        
        set {
            self[ImageCacheKey.self] = newValue
        }
    }
    
}
