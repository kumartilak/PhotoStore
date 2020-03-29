//
//  PhotoCollectionViewController.swift
//  PhotoStore
//
//  Created by Tilak Kumar on 28/03/20.
//  Copyright © 2020 Tilak Kumar. All rights reserved.
//

import UIKit

public class PhotoCollectionViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!

    var viewModel: PhotoCollectionViewModel?
    var imagePickerController: UIImagePickerController?
    
    public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, photoStoreDelegate delegate : PhotoStoreDelegate) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewModel = PhotoCollectionViewModel(viewDelegate: self, photoStoreDelegate: delegate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTopBarButtonItems()
                
        self.photoCollectionView.dataSource = self.viewModel
        self.photoCollectionView.delegate = self.viewModel
        
        self.photoCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: Bundle.init(for: PhotoCollectionViewCell.self)), forCellWithReuseIdentifier: "PhotoCollectionCell")
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.refreshFeeds()
    }
    
    fileprivate func addTopBarButtonItems() {
        
        self.title = "Photo Store"
        
        let addButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonClicked))
        addButtonItem.tag = 1
        
        self.navigationItem.setRightBarButton(addButtonItem, animated: true)
    }
    
    @objc func addButtonClicked() {
        self.viewModel?.addButtonAction()
    }
}
