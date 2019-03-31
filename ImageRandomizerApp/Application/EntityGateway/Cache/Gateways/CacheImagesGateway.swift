//
//  CacheImagesGateway.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/31/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation
import RxSwift

protocol CacheImagesGateway: ImagesGateway {}

class CacheImagesGatewayImpl: CacheImagesGateway {
    private let apiImagesGateway: ApiImagesGateway
    private let localPersistanceImagesGateway: LocalPersistenceImagesGateway
    private var disposeBag = DisposeBag()
    
    init(apiImagesGateway: ApiImagesGateway,
         localPersistanceImagesGateway: LocalPersistenceImagesGateway) {
        self.apiImagesGateway = apiImagesGateway
        self.localPersistanceImagesGateway = localPersistanceImagesGateway
    }
    
    /// Fetch images from cache storage.
    /// If images does not exist, fetch it from api and save to cache.
    ///
    /// - Returns: Observer with images
    func fetchImages() -> Observable<[Image]> {
        return Observable<[Image]>
            .create { [weak self] observer in
                guard let this = self else {
                    observer.onError(ObservableError.instanceDeallocated)
                    observer.onCompleted()
                    return Disposables.create()
                }
                
                this.localPersistanceImagesGateway
                    .fetchImages()
                    .subscribe(onNext: { images in
                        if images.isEmpty {
                            this.apiImagesGateway
                                .fetchImages()
                                .subscribe(onNext: { images in
                                    this.localPersistanceImagesGateway
                                        .add(images: images)
                                        .subscribe()
                                        .disposed(by: this.disposeBag)
                                    observer.onNext(images)
                                    observer.onCompleted()
                                }, onError: { error in
                                    observer.onError(error)
                                    observer.onCompleted()
                                }).disposed(by: this.disposeBag)
                        } else {
                            observer.onNext(images)
                            observer.onCompleted()
                        }
                    }, onError: { error in
                        observer.onError(error)
                        observer.onCompleted()
                    }).disposed(by: this.disposeBag)
                
                return Disposables.create()
        }
    }
}
