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
    func display(navigationTitle: String)
    func display(image: Image)
    func display(upperButtonTitle: String)
    func display(bottomButtonTitle: String)
    func displayInfoIcon(name: String)
    func endEditing()
    func hideBackButtonText()
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
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.presenter?
                    .endEditingImageName(text: self?.nameTextField.text)
            })
            .disposed(by: disposeBag)
        
        view.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.presenter?.pressedView(text: self?.nameTextField.text)
            }).disposed(by: disposeBag)
        
        bottomButton.rx
            .controlEvent([.touchUpInside])
            .asDriver()
            .throttle(1.0, latest: true)
            .drive(onNext: { [weak self] _ in
                self?.presenter?.pressedBottomButton()
            }).disposed(by: disposeBag)
        
        upperButton.rx
            .controlEvent([.touchUpInside])
            .asDriver()
            .throttle(1.0, latest: true)
            .drive(onNext: { [weak self] _ in
                self?.presenter?.pressedUpperButton()
            }).disposed(by: disposeBag)
        
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = item
        
        imageView.layer.cornerRadius = 20.0
        bottomButton.layer.cornerRadius = 10.0
        upperButton.layer.cornerRadius = 10.0
        nameTextField.layer.cornerRadius = 10.0
    }
    
    func display(navigationTitle: String) {
        navigationItem.title = navigationTitle
    }
    
    func display(image: Image) {
        imageView.setImage(url: image.imageURL,
                           isIndicatorExist: false)
            .subscribe(onNext: { isLoaded in })
            .disposed(by: disposeBag)
        nameTextField.text = image.name
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
            .asDriver()
            .throttle(1.0, latest: true)
            .drive(onNext: { [weak self] in
                self?.presenter?.pressedRightBarItem()
            })
            .disposed(by: disposeBag)
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    func hideBackButtonText() {
        //navigationItem.backBarButtonItem?.title = " "
    }
}
