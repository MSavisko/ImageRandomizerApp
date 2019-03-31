//
//  ImagesListConfigurator.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 4/1/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation

protocol ImagesListConfigurator {
    func configure(imageListViewController: ImagesListViewController)
}

class ImagesListConfiguratorImpl: ImagesListConfigurator {
    var imageListPresenterDelegate: ImagesListPresenterDelegate?
    
    init(imageListPresenterDelegate: ImagesListPresenterDelegate?) {
        self.imageListPresenterDelegate = imageListPresenterDelegate
    }
    
    func configure(imageListViewController: ImagesListViewController) {
        let router = ImagesListRouterImpl()
        let presenter = ImagesListPresenterImpl(view: imageListViewController,
                                                router: router,
                                                delegate: imageListPresenterDelegate)
        imageListViewController.presenter = presenter
    }
}
