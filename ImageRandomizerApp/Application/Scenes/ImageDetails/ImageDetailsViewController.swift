//
//  ImageDetailsViewController.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/27/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

protocol ImageDetailsView: class {
    func setup()
    func display(image: Image)
    func display(upperButtonTitle: String)
    func display(bottomButtonTitle: String)
    func displayInfoIcon(name: String)
    func endEditing()
}

class ImageDetailsViewController: UIViewController {
    // MARK: UI
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var upperButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    private var rightBarButton: UIBarButtonItem?
    
    private var disposeBag = DisposeBag()
    var configurator: ImageDetailsConfigurator = ImageDetailsConfiguratorImpl()
    var presenter: ImageDetailsPresenter?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(imageDetailsViewController: self)
        presenter?.viewDidLoad()
    }
}

extension ImageDetailsViewController: ImageDetailsView {
    func setup() {
        rightBarButton = UIBarButtonItem(image: nil,
                                         style: .plain,
                                         target: nil,
                                         action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
        
        nameTextField.rx
            .controlEvent([.editingDidEndOnExit])
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?
                    .endEditingImageName(text: self?.nameTextField.text)
            })
            .disposed(by: disposeBag)
        
        view.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?.pressedView()
            }).disposed(by: disposeBag)
        
        bottomButton.rx
            .controlEvent([.touchUpInside])
            .subscribe(onNext: { [weak self] in
                self?.presenter?.pressedBottomButton()
            }).disposed(by: disposeBag)
        
        upperButton.rx
            .controlEvent([.touchUpInside])
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?.pressedUpperButton()
            }).disposed(by: disposeBag)
    }
    
    func display(image: Image) {
        imageView.setImage(url: image.imageURL,
                           isIndicatorExist: false)
            .subscribe(onNext: { isLoaded in })
            .disposed(by: disposeBag)
    }
    
    func display(upperButtonTitle: String) {
        upperButton.setTitle(upperButtonTitle,
                             for: .normal)
    }
    
    func display(bottomButtonTitle: String) {
        bottomButton.setTitle(bottomButtonTitle,
                              for: .normal)
    }
    
    func displayInfoIcon(name: String) {
        rightBarButton?.image = UIImage(named: name)
        guard let button = rightBarButton else {
            return
        }
        button.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.presenter?.pressedRightBarItem()
            })
            .disposed(by: disposeBag)
    }
    
    func endEditing() {
        view.endEditing(true)
    }
}
