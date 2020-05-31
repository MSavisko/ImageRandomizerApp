//
//  ChooseImageUseCaseTests.swift
//  ImageRandomizerAppTests
//
//  Created by Maksym Savisko on 31.05.2020.
//  Copyright © 2020 Maksym Savisko. All rights reserved.
//

import XCTest
import RxSwift
@testable import ImageRandomizerApp

// MARK: -
// MARK: ChooseImageUseCase
class ChooseImageUseCaseTests: XCTestCase {
    
    private var disboseBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        disboseBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        disboseBag = nil
        try super.tearDownWithError()
    }
    
    func testChooseImageRandom() throws {
        //
        let sut = makeRandomSUT()
        
        //
        let actual = sut.chooseImage(parameters: .random)
        
        //
        let expectRandomImage = expectation(description: "Random images observed")
        actual.subscribe(onNext: { image in
            XCTAssertEqual(image, self.makeRandomImages()[0])
            expectRandomImage.fulfill()
        }).disposed(by: disboseBag)
        wait(for: [expectRandomImage], timeout: 0.5)
    }
    
    func testChooseImageRandomWhenImagesEmpty() throws {
        //
        let sut = makeEmptyImageRandomSUT()
        
        //
        let actual = sut.chooseImage(parameters: .random)
        
        //
        let expectNoImageFound = expectation(description: "Random images observed")
        actual.subscribe(onNext: { image in
            XCTFail("Do not expect image: \(image)")
            return
        }, onError: { error in
            
            func unexpectedError(_ error: Error, line: Int = #line) {
                XCTFail("Unexpected error: \(error)")
            }
            
            guard let imageError = error as? ChooseImageError
            else {
                unexpectedError(error)
                return
            }
            
            guard case ChooseImageError.noImageFound = imageError
            else {
                unexpectedError(imageError)
                return
            }
            
            expectNoImageFound.fulfill()
        }).disposed(by: disboseBag)
        wait(for: [expectNoImageFound], timeout: 0.5)
    }
}

// MARK: -
// MARK: Helpers
extension ChooseImageUseCaseTests {
    func makeRandomSUT() -> ChooseImageUseCaseImpl {
        let firstElementRandomizer: ChooseImageRandomizer = { images in
            return images[0]
        }
        return makeSUT(images: makeRandomImages(), randomizer: firstElementRandomizer)
    }
    
    func makeEmptyImageRandomSUT() -> ChooseImageUseCaseImpl {
        let emptyElementRandomizer: ChooseImageRandomizer = { _ in
            return nil
        }
        
        return makeSUT(images: [], randomizer: emptyElementRandomizer)
    }
    
    func makeSUT(images: [Image], randomizer: @escaping ChooseImageRandomizer) -> ChooseImageUseCaseImpl {
        let cacheMock = CacheImagesGatewayMock()
        cacheMock.fetchImagesReturnValue = Observable<[Image]>.create { observer in
            
            observer.onNext(images)
            observer.onCompleted()
            
            return Disposables.create()
        }
        let persistance = LocalPersistenceImagesGatewayMock()
        
        return ChooseImageUseCaseImpl(cacheImagesGateway: cacheMock,
                                      localPersistanceImagesGateway: persistance,
                                      imageRandomizer: randomizer)
    }
    
    func makeRandomImages() -> [Image] {
        return [.empty, .init(imageId: "111", name: "Random", imageURL: nil, ratio: 1.0), .empty]
    }
}
