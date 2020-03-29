//
//  PhotoCollectionViewController+ViewModelDelegate.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 29/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import UIKit

extension PhotoCollectionViewController: PhotoCollectionViewModelDelegate {
    
    func showPhotoInFullScreen(imageModel: ImageDataModel) {
        let photoFullViewController = PhotoFullViewController(nibName: "PhotoFullViewController", bundle: Bundle(for: PhotoFullViewController.self), PhotoFullViewModel(imageDataModel: imageModel, self.viewModel))
        self.present(photoFullViewController, animated: true, completion: nil)
    }
    
    func reloadCollectionView() {
        self.photoCollectionView.reloadData()
    }
    
    func showImagePickerViewController() {
        
        var sourceType = UIImagePickerController.SourceType.photoLibrary
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            sourceType = UIImagePickerController.SourceType.camera
        }
        
        imagePickerController = UIImagePickerController()
        self.imagePickerController?.delegate = self.viewModel
        self.imagePickerController?.sourceType = sourceType
        self.present(self.imagePickerController!, animated: true, completion: nil)
    }
    
    func dismissImagePicker() {
        self.imagePickerController?.dismiss(animated: true, completion: nil)
    }
}
