//
//  UIImageView+Kingfisher.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/29/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Kingfisher
import RxCocoa
import RxSwift

public extension UIImageView {
    @discardableResult
    public func setImage(url: URL?,
                         placeholder: UIImage? = nil,
                         isIndicatorExist: Bool = false,
                         fadeDuration: Double = 0.8) -> Observable<Bool> {
        return Observable.create { observer in
            guard let imageUrl = url else {
                observer.on(.next(false))
                observer.onCompleted()
                return Disposables.create()
            }
            
            var options: KingfisherOptionsInfo?
            if fadeDuration > 0.0 {
                options = [.transition(.fade(fadeDuration)),
                           .forceTransition]
            }

            let placeholder = self.image == nil ? placeholder : self.image
            
            var wrapper = self.kf
            if isIndicatorExist {
                wrapper.indicatorType = .activity
            }
            
            self.kf.setImage(with: imageUrl,
                             placeholder: placeholder,
                             options: options,
                             progressBlock: nil) { _ in
                                observer.on(.next(true))
                                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
