//
//  ImageCache.swift
//  My Flickr
//
//  Created by Ajinkya Jagtap on 19/03/25.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private init() {}

    private let cache = NSCache<NSString, UIImage>()

    // getting Image from cache as per key if availabel
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    // setting Image to cache as per key from response
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
