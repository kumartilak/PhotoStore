//
//  PhotoFullViewModel.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 29/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import Foundation

protocol PhotoFullViewModelDelegate: NSObject {
    func removeImage(imageModel: ImageDataModel)
}

class PhotoFullViewModel {
    let selectedImageDataModel: ImageDataModel
    
    weak var delegate: PhotoFullViewModelDelegate?
    
    init(imageDataModel: ImageDataModel, _ delegate: PhotoFullViewModelDelegate?) {
        self.selectedImageDataModel = imageDataModel
        self.delegate = delegate
    }
    
    func removeImage() {
        if let del = self.delegate {
            del.removeImage(imageModel: self.selectedImageDataModel)
        }
    }
}
