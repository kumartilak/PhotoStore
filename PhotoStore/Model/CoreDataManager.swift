//
//  CoreDataManager.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 28/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func add(_ image: Data,_ dateTime: Date,_ sourceType: String) -> Bool
    func fetchAllPhotos() -> [Photo]?
    func deletePhotoWithObjectId(_ objectId: NSManagedObjectID) -> Bool
}

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let identifier: String = "com.mycompany.PhotoStore"
    
    let model: String = "PhotoDataModel"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(identifier: self.identifier)
        let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let err = error {
                fatalError("Loading of store failed: \(err)")
            }
        })
       return container
    }()
}

extension CoreDataManager: CoreDataManagerProtocol {
    func add(_ image: Data,_ dateTime: Date,_ sourceType: String) -> Bool {
        let context = self.persistentContainer.viewContext
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as! Photo
        photo.photoData = image
        photo.dateAdded = dateTime
        photo.sourceType = sourceType
        let result: Bool
        do {
            try context.save()
            print("Photo saved successfully!")
            result = true
        }
        catch let error {
            print("Failed to add Photo: \(error.localizedDescription)")
            result = false
        }
        return result
    }
    
    func fetchAllPhotos() -> [Photo]? {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")
        var photos: [Photo]? = nil
        do {
            photos = try context.fetch(fetchRequest)
        }
        catch let fetchErr {
            print("❌ Failed to fetch Photos:",fetchErr)
        }
        return photos
    }
    
    func deletePhotoWithObjectId(_ objectId: NSManagedObjectID) -> Bool {
        let context = self.persistentContainer.viewContext
        let photo = context.object(with: objectId)
        context.delete(photo)
        let result: Bool
        do {
            try context.save()
            print("Photo deleted successfully!")
            result = true
        }
        catch let error {
            print("Failed to delete Photo: \(error.localizedDescription)")
            result = false
        }
        return result
    }
}
