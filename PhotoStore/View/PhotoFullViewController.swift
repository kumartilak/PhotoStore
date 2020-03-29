//
//  PhotoFullViewController.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 29/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import UIKit

class PhotoFullViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var viewModel: PhotoFullViewModel?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, _ viewModel: PhotoFullViewModel) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imageView.image = self.viewModel?.selectedImageDataModel.image
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        self.viewModel?.removeImage()
        self.dismiss(animated: true, completion: nil)
    }
}
