//
//  ImageDetailsRouter.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/30/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewRouter {}

protocol ImageDetailsRouter: ViewRouter {
    func presentAlert(title: String, subtitle: String,
                      confirmTitle: String) -> Observable<(Bool, Bool)>
    func dismissAlert()
    func showImagesList(imageListPresenterDelegate: ImagesListPresenterDelegate)
}

class ImageDetailsRouterImpl: ImageDetailsRouter {
    private weak var imageDetailsViewController: ImageDetailsViewController?
    private weak var alertViewController: UIAlertController?
    
    init(imageDetailsViewController: ImageDetailsViewController) {
        self.imageDetailsViewController = imageDetailsViewController
    }
    
    func presentAlert(title: String, subtitle: String,
                      confirmTitle: String)
        -> Observable<(Bool, Bool)> {
        return Observable.create { [weak self] observer in
            let controller = UIAlertController(title: title,
                                               message: subtitle,
                                               preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: confirmTitle,
                                              style: .default) { _ in
                    observer.on(.next((false, true)))
                    observer.onCompleted()
            }
            controller.addAction(confirmAction)
            self?.imageDetailsViewController?.present(controller,
                                                      animated: true) {
                observer.on(.next((true, false)))
            }
            self?.alertViewController = controller
            return Disposables.create()
        }
    }
    
    func dismissAlert() {
        alertViewController?.dismiss(animated: true)
    }
    
    func showImagesList(imageListPresenterDelegate: ImagesListPresenterDelegate) {
        let imagesListConfigurator = ImagesListConfiguratorImpl(imageListPresenterDelegate: imageListPresenterDelegate)
        let imagesListViewController = ImagesListViewController()
        imagesListViewController.loadViewIfNeeded()
        imagesListViewController.configurator = imagesListConfigurator
        imageDetailsViewController?
            .navigationController?
            .pushViewController(imagesListViewController,
                                animated: true)
    }
}
