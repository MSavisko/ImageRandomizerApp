//
//  ImageDetailsConfigurator.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/27/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation

protocol ImageDetailsConfigurator {
    func configure(imageDetailsViewController: ImageDetailsViewController)
}

class ImageDetailsConfiguratorImpl: ImageDetailsConfigurator {
    func configure(imageDetailsViewController: ImageDetailsViewController) {
        let absoluteImageUrlString = "https://volleycountry.com/wp-content/uploads/2017/11/volleyball-england-popular.jpg"
        let image = Image(name: "", imageURL: URL(string: absoluteImageUrlString),
                          ratio: 1.499)
        let router = ImageDetailsRouterImpl(imageDetailsViewController: imageDetailsViewController)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let dateProvider = DateProviderImpl(dateFormatter: dateFormatter)
        let presenter = ImageDetailsPresenterImpl(view: imageDetailsViewController,
                                                  router: router,
                                                  image: image,
                                                  dateProvider: dateProvider)
        imageDetailsViewController.presenter = presenter
    }
}
