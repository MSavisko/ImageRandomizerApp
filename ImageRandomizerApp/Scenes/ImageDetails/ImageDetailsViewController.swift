//
//  ImageDetailsViewController.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/27/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import UIKit

protocol ImageDetailsView: class {
    func display(image: Image)
}

class ImageDetailsViewController: UIViewController {
    
}


extension ImageDetailsViewController: ImageDetailsView {
    // MARK: ImageDetailsView
    func display(image: Image) {
    }
}
