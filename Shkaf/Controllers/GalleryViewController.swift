//
//  GalleryViewController.swift
//  Shkaf
//
//  Created by Ума Мирзоева on 25.12.2021.
//

import UIKit

class GalleryViewController: UICollectionViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    weak var delegate: AddImageDelegate?
    private let addImageButton = UIButton()
    private var images = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3")]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(StoreItemCell.self, forCellWithReuseIdentifier: "storeCollectionView")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.layer.cornerRadius = 16
        setupImageButton()
        setupLayout()
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeCollectionView", for: indexPath) as? StoreItemCell
        cell?.imageView.image = images[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(image: images[indexPath.row])
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        images.append(image)
        collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        view.addSubview(addImageButton)
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addImageButton.heightAnchor.constraint(equalToConstant: 30),
            addImageButton.widthAnchor.constraint(equalToConstant: 30),
            addImageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            addImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupImageButton() {
        addImageButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addImageButton.backgroundColor = .secondarySystemBackground
        addImageButton.layer.cornerRadius = 15
        addImageButton.addTarget(self, action: #selector(addGalleryImageTapped), for: .touchUpInside)
    }
    
    @objc private func addGalleryImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
}
