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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var upperButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var configurator: ImageDetailsConfigurator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(imageDetailsViewController: self)
    }
}

extension ImageDetailsViewController: ImageDetailsView {
    func display(image: Image) {
        
    }
}
