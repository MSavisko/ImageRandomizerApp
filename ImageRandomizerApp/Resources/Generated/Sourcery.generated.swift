// Generated using Sourcery 0.18.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
import UserNotifications
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

//Custom Pod imports
import RxSwift
import RxCocoa













class CacheImagesGatewayMock: CacheImagesGateway {

    //MARK: - fetchImages

    var fetchImagesCallsCount = 0
    var fetchImagesCalled: Bool {
        return fetchImagesCallsCount > 0
    }
    var fetchImagesReturnValue: Observable<[Image]>!
    var fetchImagesClosure: (() -> Observable<[Image]>)?

    func fetchImages() -> Observable<[Image]> {
        fetchImagesCallsCount += 1
        return fetchImagesClosure.map({ $0() }) ?? fetchImagesReturnValue
    }

}
class LocalPersistenceImagesGatewayMock: LocalPersistenceImagesGateway {

    //MARK: - update

    var updateImageParametersCallsCount = 0
    var updateImageParametersCalled: Bool {
        return updateImageParametersCallsCount > 0
    }
    var updateImageParametersReceivedArguments: (image: Image, parameters: UpdateImageParameters)?
    var updateImageParametersReturnValue: Observable<Image>!
    var updateImageParametersClosure: ((Image, UpdateImageParameters) -> Observable<Image>)?

    func update(image: Image, parameters: UpdateImageParameters) -> Observable<Image> {
        updateImageParametersCallsCount += 1
        updateImageParametersReceivedArguments = (image: image, parameters: parameters)
        return updateImageParametersClosure.map({ $0(image, parameters) }) ?? updateImageParametersReturnValue
    }

    //MARK: - add

    var addImagesCallsCount = 0
    var addImagesCalled: Bool {
        return addImagesCallsCount > 0
    }
    var addImagesReceivedImages: [Image]?
    var addImagesReturnValue: Observable<[Image]>!
    var addImagesClosure: (([Image]) -> Observable<[Image]>)?

    func add(images: [Image]) -> Observable<[Image]> {
        addImagesCallsCount += 1
        addImagesReceivedImages = images
        return addImagesClosure.map({ $0(images) }) ?? addImagesReturnValue
    }

    //MARK: - fetchLatestImage

    var fetchLatestImageCallsCount = 0
    var fetchLatestImageCalled: Bool {
        return fetchLatestImageCallsCount > 0
    }
    var fetchLatestImageReturnValue: Observable<Image>!
    var fetchLatestImageClosure: (() -> Observable<Image>)?

    func fetchLatestImage() -> Observable<Image> {
        fetchLatestImageCallsCount += 1
        return fetchLatestImageClosure.map({ $0() }) ?? fetchLatestImageReturnValue
    }

    //MARK: - fetchImages

    var fetchImagesCallsCount = 0
    var fetchImagesCalled: Bool {
        return fetchImagesCallsCount > 0
    }
    var fetchImagesReturnValue: Observable<[Image]>!
    var fetchImagesClosure: (() -> Observable<[Image]>)?

    func fetchImages() -> Observable<[Image]> {
        fetchImagesCallsCount += 1
        return fetchImagesClosure.map({ $0() }) ?? fetchImagesReturnValue
    }

}
