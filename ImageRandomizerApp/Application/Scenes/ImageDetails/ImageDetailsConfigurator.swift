//
//  ImageDetailsConfigurator.swift
//  ImageRandomizerApp
//
//  Created by Maksym Savisko on 3/27/19.
//  Copyright © 2019 Maksym Savisko. All rights reserved.
//

import Foundation
import RealmSwift

protocol ImageDetailsConfigurator {
    func configure(imageDetailsViewController: ImageDetailsViewController)
}

class ImageDetailsConfiguratorImpl: ImageDetailsConfigurator {
    func configure(imageDetailsViewController: ImageDetailsViewController) {
        // Image
        /*
        let absoluteImageUrlString = "https://volleycountry.com/wp-content/uploads/2017/11/volleyball-england-popular.jpg"
        let image = Image(imageId: UUID().uuidString,
                          name: "",
                          imageURL: URL(string: absoluteImageUrlString),
                          ratio: 1.499)
        */
        let image = Image.empty
        
        // Router
        let router = ImageDetailsRouterImpl(imageDetailsViewController: imageDetailsViewController)
        
        // Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let dateProvider = LocalDateGatewayImpl(dateFormatter: dateFormatter)
        
        // Choose Image Use Case
        let apiClient = ApiClientImpl(urlSessionConfiguration: .default,
                                      completionHandlerQueue: .main)
        let apiImageGateway = ApiImagesGatewayImpl(apiClient: apiClient)
        
        let realm = try! Realm()
        let localImagesGateway = LocalPersistenceImagesGatewayImpl(realm: realm)
        let cacheImagesGateway = CacheImagesGatewayImpl(apiImagesGateway: apiImageGateway,
                                                        localPersistanceImagesGateway: localImagesGateway)
        let chooseImageUseCase = ChooseImageUseCaseImpl(cacheImagesGateway: cacheImagesGateway,
                                                        localPersistanceImagesGateway: localImagesGateway)
        
        // Update Image Use Case
        let updateImageUseCase = UpdateImageUseCaseImpl(localPersistenceImagesGateway: localImagesGateway)
        
        // Presenter
        let presenter = ImageDetailsPresenterImpl(view: imageDetailsViewController,
                                                  router: router,
                                                  image: image,
                                                  dateProvider: dateProvider,
                                                  chooseImageUseCase: chooseImageUseCase,
                                                  updateImageUseCase: updateImageUseCase)
        imageDetailsViewController.presenter = presenter
    }
}
