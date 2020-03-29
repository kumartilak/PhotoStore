//
//  PhotoCollectionViewModel+CollectionViewDelegate.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 29/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import UIKit

extension PhotoCollectionViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = self.imagesArray else {
            return 0
        }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionViewCell
        
        if let images = self.imagesArray {
            let imageData = images[indexPath.row]
            
            cell.photoImageView.image = imageData.image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let images = self.imagesArray {
            let imageData = images[indexPath.row]
            if let delegate = self.viewDelegate {
                delegate.showPhotoInFullScreen(imageModel: imageData)
            }
        }
    }
}
