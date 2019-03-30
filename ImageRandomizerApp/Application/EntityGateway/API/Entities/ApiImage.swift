//
//  ApiImage.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/30/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation

struct ApiImage: Codable {
    let ratio: Double
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case ratio
        case imageUrl = "image_url"
    }
}

extension ApiImage {
    var image: Image {
        return Image(name: "",
                     imageURL: URL(string: imageUrl),
                     ratio: ratio)
    }
}
