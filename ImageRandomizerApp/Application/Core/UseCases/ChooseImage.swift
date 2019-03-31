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
    case noImageFound
}

class ChooseImageUseCaseImpl: ChooseImageUseCase {
    let cacheImagesGateway: CacheImagesGateway
    private var disposeBag = DisposeBag()
    
    init(cacheImagesGateway: CacheImagesGateway) {
        self.cacheImagesGateway = cacheImagesGateway
    }
    
    func chooseImage(parameters: ChooseImageParameters) -> Observable<Image> {
        return Observable<Image>
            .create { [weak self] observer in                
                switch parameters {
                case .random:
                    self?.handleRandomImageChoose(observer: observer)
                }
                
                return Disposables.create()
        }
    }
    
    private func handleRandomImageChoose(observer: AnyObserver<Image>) {
        cacheImagesGateway.fetchImages()
            .subscribe(onNext: { images in
                guard
                    let image = images.randomElement()
                else {
                    observer.onError(ChooseImageError.noImageFound)
                    observer.onCompleted()
                    return
                }
                observer.onNext(image)
                observer.onCompleted()
            }, onError: { error in
                observer.onError(error)
                observer.onCompleted()
            }).disposed(by: disposeBag)
    }
}
