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
        let image = Image.empty
        
        // Router
        let router = ImageDetailsRouterImpl(imageDetailsViewController: imageDetailsViewController)
        
        // Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let localDateGateway = LocalDateGatewayImpl(dateFormatter: dateFormatter)
        
        // Choose Image Use Case
        let apiClient = ApiClientImpl(urlSessionConfiguration: .default,
                                      completionHandlerQueue: .main)
        let apiImageGateway = ApiImagesGatewayImpl(apiClient: apiClient)
        
        guard let datadase = try? Realm() else {
            return
        }
        let localImagesGateway = LocalPersistenceImagesGatewayImpl(realm: datadase)
        let cacheImagesGateway = CacheImagesGatewayImpl(apiImagesGateway: apiImageGateway,
                                                        localPersistanceImagesGateway: localImagesGateway)
        let defaultRandomizer: ChooseImageRandomizer = { images in
            return images.randomElement()
        }
        let chooseImageUseCase = ChooseImageUseCaseImpl(cacheImagesGateway: cacheImagesGateway,
                                                        localPersistanceImagesGateway: localImagesGateway,
                                                        imageRandomizer: defaultRandomizer)
        
        // Update Image Use Case
        let updateImageUseCase = UpdateImageUseCaseImpl(localPersistenceImagesGateway: localImagesGateway)
        
        // Presenter
        let presenter = ImageDetailsPresenterImpl(view: imageDetailsViewController,
                                                  router: router,
                                                  image: image,
                                                  dateProvider: localDateGateway,
                                                  chooseImageUseCase: chooseImageUseCase,
                                                  updateImageUseCase: updateImageUseCase)
        imageDetailsViewController.presenter = presenter
    }
}
