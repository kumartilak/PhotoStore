//
//  ImageDataModel.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 29/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import CoreData
import UIKit

struct ImageDataModel {
    let image: UIImage
    let date: Date
    let sourceType: String
    let objId: NSManagedObjectID
    var isSaved: Bool = false
    
    init(photo: Photo) {
        self.image = UIImage(data: photo.photoData!)!
        self.date = photo.dateAdded!
        self.sourceType = photo.sourceType!
        self.objId = photo.objectID
        self.isSaved = true
    }
}
