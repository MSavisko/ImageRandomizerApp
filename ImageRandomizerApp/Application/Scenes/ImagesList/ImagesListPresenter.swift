//
//  ImagesListPresenter.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 4/1/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation

protocol ImagesListPresenterDelegate: class {
    func imagesListPresenter(_ presenter: ImagesListPresenter,
                             didSelect image: Image)
}

protocol ImagesListPresenter: class {
    var router: ImagesListRouter { get }
    func viewDidLoad()
}

class ImagesListPresenterImpl: ImagesListPresenter {
    private weak var view: ImagesListView?
    var router: ImagesListRouter
    private weak var delegate: ImagesListPresenterDelegate?
    
    init(view: ImagesListView,
         router: ImagesListRouter,
         delegate: ImagesListPresenterDelegate?) {
        self.view = view
        self.router = router
        self.delegate = delegate
    }
    
    // MARK: ImagesListPresenter
    func viewDidLoad() {
        
    }
}
