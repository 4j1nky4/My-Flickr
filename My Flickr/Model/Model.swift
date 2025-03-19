//
//  Model.swift
//  My Flickr
//
//  Created by Ajinkya Jagtap on 19/03/25.
//

import Foundation

struct ImageResponse: Codable {
    let photos: [ImageData]
}

struct ImageData: Codable {
    let id: Int
    let src: ImageSrc
}

// Image source url as per image size
struct ImageSrc: Codable {
    let small: String
    let medium: String
    let large: String
}
