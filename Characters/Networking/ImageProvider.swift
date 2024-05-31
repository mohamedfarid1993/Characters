//
//  ImageProvider.swift
//  Characters
//
//  Created by Mohamed Farid on 31/05/2024.
//

import UIKit
import AVKit
import Photos
import PhotosUI
import Kingfisher

// MARK: UIImageView Image Loading

enum ImageProvider {
    
    // MARK: Configuration
    
    struct Configuration {
        
        static let `default` = Configuration()
        
        let placeholder: UIImage?
        let size: CGSize?
        
        init(placeholder: UIImage? = nil, size: CGSize? = nil) {
            self.placeholder = placeholder
            self.size = size
        }
    }
    
    // MARK: Image Loading
    
    static func loadImage(with url: URL?, into imageView: UIImageView, using configuration: Configuration = .default) {
        guard let imageURL = url else {
            imageView.image = configuration.placeholder
            return
        }
        
        imageView.kf.setImage(
            with: imageURL,
            placeholder: configuration.placeholder,
            options: getImageOptions(using: configuration)
        )
    }
    
    // MARK: Image Options
    
    private static func getImageOptions(using configuration: Configuration) -> KingfisherOptionsInfo {
        
        var options: KingfisherOptionsInfo = [
            .loadDiskFileSynchronously,
            .transition(.fade(0.1)),
            .cacheSerializer(FormatIndicatedCacheSerializer.png),
            .diskCacheExpiration(.seconds(2_592_000)) // Cache for one month
        ]
        
        guard let resizingProcessor = getResizingProcessor(using: configuration) else { return options }
        options.append(.processor(resizingProcessor))
        return options
    }
    
    // MARK: Resizing Processor
    
    static func getResizingProcessor(using configuration: Configuration) -> DownsamplingImageProcessor? {
        
        guard let size = configuration.size  else { return nil }
        let scale = UIScreen.main.scale
        return DownsamplingImageProcessor(size: CGSize(width: size.width * scale, height: size.height * scale))
    }
}
