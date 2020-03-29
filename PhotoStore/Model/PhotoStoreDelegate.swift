//
//  PhotoStoreDelegate.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 29/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import Foundation
import Bluebird

public protocol PhotoStoreDelegate: NSObject {
    func allowPhotoStoreToSaveImage() -> Promise<Bool>
    func allowPhotoStoreToDeleteImage() -> Promise<Bool>
}
