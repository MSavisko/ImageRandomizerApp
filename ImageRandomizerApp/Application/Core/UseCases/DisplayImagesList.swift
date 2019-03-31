//
//  DisplayImagesList.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/31/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation
import RxSwift

protocol DisplayImagesList {
    func displayImages() -> Observable<[Image]>
}

class DisplayImagesListImpl: DisplayImagesList {
    private let imagesGateway: ImagesGateway
    
    init(imagesGateway: ImagesGateway) {
        self.imagesGateway = imagesGateway
    }
    
    func displayImages() -> Observable<[Image]> {
        return imagesGateway.fetchImages()
    }
}
