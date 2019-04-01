//
//  ImagesListViewController.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 4/1/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import UIKit

protocol ImagesListView: class {
    func display(navigationTitle: String)
    func display(images: [Image])
}

class ImagesListViewController: UIViewController, ImagesListView {
    var configurator: ImagesListConfigurator?
    var presenter: ImagesListPresenter?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(imageListViewController: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: ImagesListView
    func display(navigationTitle: String) {
        
    }
    
    func display(images: [Image]) {
        
    }
}
