//
//  PhotoCollectionViewModel+ImagePickerDelegate.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 29/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import UIKit
import Bluebird

extension PhotoCollectionViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let delegate = self.viewDelegate {
            delegate.dismissImagePicker()
        }
    
        self.handleImagePicked(info: info)
    }
    
    fileprivate func handleImagePicked(info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            
            guard let storeDelegate = self.photoStoreDelegate else {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                storeDelegate.allowPhotoStoreToSaveImage()
                .then{ result in
                    if result {
                        self.saveImageToCoreData(pickedImage, info[.mediaType] as? String ?? "Unknown")
                        .then{ result in
                            self.refreshFeeds()
                        }
                    }
                    else {
                        print("Parent didnt allow saving of image")
                    }
                }
            }
        }
    }
    
    fileprivate func saveImageToCoreData(_ image: UIImage, _ sourceType: String) -> Promise<Bool> {
        return self.imageHandler.save(image: image, sourceType: sourceType)
    }
}
