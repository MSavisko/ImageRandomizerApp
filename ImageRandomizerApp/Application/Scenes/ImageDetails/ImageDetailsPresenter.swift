//
//  ImageDetailsPresenter.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/27/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageDetailsPresenter: class {
    var router: ImageDetailsRouter { get }
    func viewDidLoad()
    func viewWillAppear()
    func endEditingImageName(text: String?)
    func pressedRightBarItem()
    func pressedView(text: String?)
    func pressedBottomButton()
    func pressedUpperButton()
}

class ImageDetailsPresenterImpl: ImageDetailsPresenter {
    private weak var view: ImageDetailsView?
    private var image: Image
    var router: ImageDetailsRouter
    private let dateProvider: DateGateway
    private let chooseImageUseCase: ChooseImageUseCase
    private let updateImageUseCase: UpdateImageUseCase
    
    private var disposeBag = DisposeBag()
    
    init(view: ImageDetailsView,
         router: ImageDetailsRouter,
         image: Image,
         dateProvider: DateGateway,
         chooseImageUseCase: ChooseImageUseCase,
         updateImageUseCase: UpdateImageUseCase) {
        self.view = view
        self.router = router
        self.image = image
        self.dateProvider = dateProvider
        self.chooseImageUseCase = chooseImageUseCase
        self.updateImageUseCase = updateImageUseCase
    }
    
    // MARK: ImageDetailsPresenter
    func viewDidLoad() {
        view?.setup()
        chooseLatestImage()
        view?.display(navigationTitle: "Details")
        view?.display(image: image)
        view?.display(upperButtonTitle: "SELECT")
        view?.display(bottomButtonTitle: "RANDOM")
        view?.displayInfoIcon(name: "info-icon")
    }
    
    func viewWillAppear() {
        view?.displayNavigationBar(colorName: "light-grey")
        view?.displayNavigationBarTitle(colorName: "light-black",
                                        fontSize: 20.0)
        view?.displayBackButton(colorName: "blue")
    }
    
    func endEditingImageName(text: String?) {
        updateImageUseCase
            .update(image: image,
                    parameters: .init(name: text,
                                      isLatest: true))
            .subscribe(onNext: { [weak self] image in
                self?.image = image
            }).disposed(by: disposeBag)
    }
    
    func pressedRightBarItem() {
        router
            .presentAlert(title: "Created by Maksym Savisko",
                          subtitle: "The time now is \(dateProvider.formattedStringCurrentDate())",
                          confirmTitle: "OK")
            .subscribe(onNext: { [weak self] (isPresented, _) in
                if isPresented {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
                        self?.router.dismissAlert()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func pressedView(text: String?) {
        view?.endEditing()
        endEditingImageName(text: text)
    }
    
    func pressedBottomButton() {
        chooseImageUseCase
            .chooseImage(parameters: .random)
            .subscribe(onNext: { [weak self] image in
                self?.image = image
                self?.view?.display(image: image)
            }, onError: { [weak self] error in
                self?.handleAppearing(error)
            }).disposed(by: disposeBag)
    }
    
    func pressedUpperButton() {
        router.showImagesList(imageListPresenterDelegate: self)
    }
    
    // MARK: Handlers
    private func chooseLatestImage() {
        chooseImageUseCase
            .chooseImage(parameters: .latest)
            .subscribe(onNext: { [weak self] image in
                self?.image = image
                self?.view?.display(image: image)
            }, onError: { [weak self] error in
                self?.handleAppearing(error)
            }).disposed(by: disposeBag)
    }
    
    private func handleAppearing(_ error: Error) {
        router
            .presentAlert(title: "Error",
                          subtitle: error.localizedDescription,
                          confirmTitle: "OK")
            .subscribe(onNext: { _ in })
            .disposed(by: disposeBag)
    }
}

// MARK: ImagesListPresenterDelegate
extension ImageDetailsPresenterImpl: ImagesListPresenterDelegate {
    func imagesListPresenter(_ presenter: ImagesListPresenter,
                             didSelect image: Image) {
        view?.display(image: image)
        presenter.router.dismissView()
    }
}
