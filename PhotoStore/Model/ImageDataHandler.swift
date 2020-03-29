//
//  ImageDataHandler.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 29/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import UIKit
import Bluebird

protocol ImageDataHandlerProtocol {
    func getAllSavedImages() -> Promise<[ImageDataModel]>
    func save(image: UIImage, sourceType: String) -> Promise<Bool>
    func delete(imageModel: ImageDataModel) -> Promise<Bool>
}

class ImageDataHandler: ImageDataHandlerProtocol{
    let coreDataManager: CoreDataManager
    
    init(dataManager: CoreDataManager) {
        self.coreDataManager = dataManager
    }

    func getAllSavedImages() -> Promise<[ImageDataModel]> {
        return Promise<[ImageDataModel]> { resolve, reject in
            DispatchQueue(label: "coredata.fetch.operation").async {
                if let photoArray = self.coreDataManager.fetchAllPhotos() {
                    var imageArray = [ImageDataModel]()
                    for photo in photoArray {
                        let imageDataModel = ImageDataModel(photo: photo)
                        imageArray.append(imageDataModel)
                    }
                    resolve(imageArray)
                }
                else {
                    let error = NSError(domain:"Failed fetching photos from CoreData", code:0, userInfo:nil)
                    reject(error)
                }
            }
        }
    }
    
    func save(image: UIImage, sourceType: String) -> Promise<Bool> {
        return Promise<Bool> { resolve, reject in
            DispatchQueue(label: "coredata.add.operation").async {
                if let imageData = image.pngData() {
                    if CoreDataManager.shared.add(imageData, Date(), sourceType) {
                        resolve(true)
                    }
                    else {
                        let error = NSError(domain:"Failed saving photo to CoreData", code:0, userInfo:nil)
                        reject(error)
                    }
                }
            }
        }
    }
    
    func delete(imageModel: ImageDataModel) -> Promise<Bool> {
        return Promise<Bool> { resolve, reject in
            DispatchQueue(label: "coredata.delete.operation").async {
                if CoreDataManager.shared.deletePhotoWithObjectId(imageModel.objId) {
                    resolve(true)
                }
                else {
                    let error = NSError(domain:"Failed removing photo from CoreData", code:0, userInfo:nil)
                    reject(error)
                }
            }
        }
    }
}
