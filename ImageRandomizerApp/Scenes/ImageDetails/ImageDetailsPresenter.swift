//
//  ImageDetailsPresenter.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/27/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation

protocol ImageDetailsPresenter: class {
    func viewDidLoad()
}

class ImageDetailsPresenterImpl: ImageDetailsPresenter {
    private weak var view: ImageDetailsView?
    private var image: Image
    
    init(view: ImageDetailsView,
         image: Image) {
        self.view = view
        self.image = image
    }
    
    func viewDidLoad() {
        view?.display(image: image)
    }
}
