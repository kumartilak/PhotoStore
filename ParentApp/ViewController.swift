//
//  ViewController.swift
//  ParentApp
//
//  Created by Tilak Kumar on 28/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import UIKit
import PhotoStore
import Bluebird

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func launchPhotoCollection() {
        let bundle = Bundle(for: PhotoCollectionViewController.self)
        let photoCollectionViewController = PhotoCollectionViewController(nibName: "PhotoCollectionViewController", bundle: bundle, photoStoreDelegate: self)
        self.navigationController?.pushViewController(photoCollectionViewController, animated: true)
    }
}

extension ViewController: PhotoStoreDelegate {
    func allowPhotoStoreToSaveImage() -> Promise<Bool> {
        return self.showAlertViewToGetUserConsent("Would you like to save the photo in gallery?")
    }
    
    func allowPhotoStoreToDeleteImage() -> Promise<Bool> {
        return self.showAlertViewToGetUserConsent("Are you sure to delete photo from gallery?")
    }
    
    fileprivate func showAlertViewToGetUserConsent(_ message: String) -> Promise<Bool> {
        return Promise<Bool> { resolve, reject in
            
            let alertController = UIAlertController(title: "Photo Store", message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
                resolve(true)
            }))
            alertController.addAction(UIAlertAction(title: "NO", style: .default, handler: { action in
                resolve(false)
            }))
                        
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


