//
//  ChooseImage.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/30/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation
import RxSwift

protocol ChooseImageUseCase {
    func chooseImage(parameters: ChooseImageParameters) -> Observable<Image>
}

enum ChooseImageParameters: Equatable {
    case random
}

enum ChooseImageError: Error {
    case noImagaFound
}

class ChooseImageUseCaseImpl: ChooseImageUseCase {
    let apiImagesGateway: ApiImagesGateway
    private var disposeBag = DisposeBag()
    
    init(apiImagesGateway: ApiImagesGateway) {
        self.apiImagesGateway = apiImagesGateway
    }
    
    func chooseImage(parameters: ChooseImageParameters) -> Observable<Image> {
        return Observable<Image>
            .create { [weak apiImagesGateway, weak disposeBag] observer in
                guard
                    let gateway = apiImagesGateway,
                    let bag = disposeBag
                else {
                    observer.onCompleted()
                    return Disposables.create()
                }
                
                gateway
                    .fetchImages()
                    .subscribe(onNext: { images in
                        guard
                            let image = images.randomElement()
                        else {
                            observer.onError(ChooseImageError.noImagaFound)
                            observer.onCompleted()
                            return
                        }
                        observer.onNext(image)
                        observer.onCompleted()
                    }).disposed(by: bag)
                
                return Disposables.create()
        }
    }
}
