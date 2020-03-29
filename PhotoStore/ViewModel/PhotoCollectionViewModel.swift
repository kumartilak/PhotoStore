//
//  PhotoCollectionViewModel.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 28/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import UIKit
import Bluebird

protocol PhotoCollectionViewModelDelegate: NSObject {
    func showImagePickerViewController()
    func dismissImagePicker()
    func reloadCollectionView()
    func showPhotoInFullScreen(imageModel: ImageDataModel)
}

class PhotoCollectionViewModel: NSObject {
    weak var viewDelegate: PhotoCollectionViewModelDelegate?
    weak var photoStoreDelegate: PhotoStoreDelegate?
    let imageHandler: ImageDataHandler
    var imagesArray: [ImageDataModel]?
    
    required init(viewDelegate delegate: PhotoCollectionViewModelDelegate, photoStoreDelegate storeDelegate: PhotoStoreDelegate) {
        self.viewDelegate = delegate
        self.photoStoreDelegate = storeDelegate
        self.imageHandler = ImageDataHandler(dataManager: CoreDataManager.shared)
    }
    
    func refreshFeeds() {
        self.imageHandler.getAllSavedImages()
        .then { [weak self] images in
            self?.imagesArray = images
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let delegate = self?.viewDelegate {
                    delegate.reloadCollectionView()
                }
            }
        }
    }
    
    func addButtonAction() {
        if let delegate = self.viewDelegate {
            delegate.showImagePickerViewController()
        }
    }
}

extension PhotoCollectionViewModel: PhotoFullViewModelDelegate {
    func removeImage(imageModel: ImageDataModel) {
    guard let storeDelegate = self.photoStoreDelegate else {
        return
    }
                   
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
           storeDelegate.allowPhotoStoreToDeleteImage()
           .then{ result in
               if result {
                   self.imageHandler.delete(imageModel: imageModel)
                   .then { result in
                       if result {
                           self.refreshFeeds()
                       }
                   }
               }
               else {
                   print("Parent didnt allow deleting of image")
               }
           }
       }
    }
}
