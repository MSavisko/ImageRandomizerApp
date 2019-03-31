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
