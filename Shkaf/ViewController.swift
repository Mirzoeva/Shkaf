//
//  ViewController.swift
//  Shkaf
//
//  Created by Ума Мирзоева on 23.12.2021.
//

import UIKit

class ViewController: UIViewController {
    let look: LookViewController = LookViewController()
    let gallery = GalleryViewController(collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Look"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearTapped))
                
        view.addSubview(look.view)
        addChild(look)
        look.didMove(toParent: self)
        
        view.addSubview(gallery.view)
        addChild(gallery)
        gallery.didMove(toParent: self)
        
        gallery.delegate = look
        setupLayout()
    }
    
    private func setupLayout() {
        look.view.backgroundColor = .systemBackground
        look.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            look.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            look.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            look.view.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            look.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            
        ])
        
        gallery.collectionView.backgroundColor = .systemGray5
        gallery.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gallery.view.topAnchor.constraint(equalTo: look.view.bottomAnchor, constant: 20),
            gallery.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gallery.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            gallery.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 20)
        ])

    }
    
    @objc func clearTapped() {
        look.clearImages()
    }

}


