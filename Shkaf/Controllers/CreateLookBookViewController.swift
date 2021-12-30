//
//  CreateLookBookViewController.swift
//  Shkaf
//
//  Created by Ума Мирзоева on 23.12.2021.
//

import UIKit

class CreateLookBookViewController: UIViewController, AddImageDelegate {
    
    // MARK: - Properties
    
    let lookView = LookView()
    let galleryController = GalleryViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Look"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearTapped))
        
        setupLookView()
        setupGalleryController()
        setupLayout()
    }
    
    // MARK: - Public
    
    func didSelect(image: UIImage?) {
        let item = UIImageView(image: image)
        lookView.addNewClother(image: item)
    }
    
    // MARK: - Private
    
    private func setupLookView() {
        view.addSubview(lookView)
        lookView.alertCompletion = { [weak self] controller in
            self?.present(controller, animated: true, completion: nil)
        }
    }
    
    private func setupGalleryController() {
        view.addSubview(galleryController.view)
        addChild(galleryController)
        galleryController.didMove(toParent: self)
        galleryController.delegate = self
    }
    
    private func setupLayout() {
        lookView.backgroundColor = .systemBackground
        lookView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lookView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            lookView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lookView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            lookView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            
        ])
        
        galleryController.collectionView.backgroundColor = .systemGray5
        galleryController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            galleryController.view.topAnchor.constraint(equalTo: lookView.bottomAnchor, constant: 20),
            galleryController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            galleryController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            galleryController.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 20)
        ])

    }
    
    @objc private func clearTapped() {
        lookView.clearImages()
    }

}


