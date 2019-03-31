//
//  ImagesListViewController.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 4/1/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import UIKit

protocol ImagesListView: class {
}

class ImagesListViewController: UIViewController, ImagesListView {
    var configurator: ImagesListConfigurator?
    var presenter: ImagesListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(imageListViewController: self)
        presenter?.viewDidLoad()
    }
}
