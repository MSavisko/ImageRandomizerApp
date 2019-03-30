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
    func viewDidLoad()
    func endEditingImageName(text: String?)
    func pressedRightBarItem()
    func pressedView()
}

class ImageDetailsPresenterImpl: ImageDetailsPresenter {
    private weak var view: ImageDetailsView?
    private var image: Image
    private var router: ImageDetailsRouter
    private let dateProvider: DateProvider
    
    private var disposeBag = DisposeBag()
    
    init(view: ImageDetailsView,
         router: ImageDetailsRouter,
         image: Image,
         dateProvider: DateProvider) {
        self.view = view
        self.router = router
        self.image = image
        self.dateProvider = dateProvider
    }
    
    // MARK: ImageDetailsPresenter
    func viewDidLoad() {
        view?.setup()
        view?.display(image: image)
        view?.display(upperButtonTitle: "Select")
        view?.display(bottomButtonTitle: "Random")
        view?.displayInfoIcon(name: "info-icon")
    }
    
    func endEditingImageName(text: String?) {
        image.name = text ?? ""
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
    
    func pressedView() {
        view?.endEditing()
    }
}
