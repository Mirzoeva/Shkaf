//
//  LookViewController.swift
//  Shkaf
//
//  Created by Ума Мирзоева on 25.12.2021.
//

import UIKit

class LookViewController: UIViewController, AddImageDelegate {
    private let widthItem: CGFloat = 100
    private let heightItem: CGFloat = 100
    private var lookItems: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupItem(item: UIImageView) {
        view.addSubview(item)
        let scaleRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(scaleHandler(gestureRecognizer:)))
        
        let fingerRecognizer = UIPanGestureRecognizer(target: self, action: #selector(fingerHandler(recognizer:)))
        
        let tappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandler(tapRecognizer:)))
        
        let deleteItemRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(pressRecognizer:)))
        
        item.addGestureRecognizer(scaleRecognizer)
        item.isUserInteractionEnabled = true
        item.addGestureRecognizer(fingerRecognizer)
        item.addGestureRecognizer(tappedRecognizer)
        item.addGestureRecognizer(deleteItemRecognizer)
        
    }
    
    @objc func scaleHandler(gestureRecognizer: UIPinchGestureRecognizer) {
        guard let item = gestureRecognizer.view else { return }
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
           item.transform = (item.transform.scaledBy(
            x: gestureRecognizer.scale,
            y: gestureRecognizer.scale)
           )
           gestureRecognizer.scale = 1.0
        }
    }
    
    @objc func fingerHandler(recognizer: UIPanGestureRecognizer) {
        guard let item = recognizer.view else { return }
        let translation = recognizer.translation(in: self.view)
        let newFrame = CGRect(
            x: item.center.x - item.frame.width/2 + translation.x,
            y: item.center.y - item.frame.height/2 + translation.y,
            width: item.frame.width,
            height: item.frame.height
        )
        if view.bounds.contains(newFrame) {
            item.frame = newFrame
            recognizer.setTranslation(.zero, in: view)
        }
        view.bringSubviewToFront(item)
    }
    
    @objc func tappedHandler(tapRecognizer: UITapGestureRecognizer) {
        guard let item = tapRecognizer.view else { return }
        view.bringSubviewToFront(item)
    }
    
    @objc func longPressHandler(pressRecognizer: UILongPressGestureRecognizer) {
        let alert = UIAlertController(title: "Удалить элемент?", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { [weak self] _ in
            guard let item = pressRecognizer.view,
                  let index = self?.lookItems.firstIndex(where: { image in image === item }) else { return }
            self?.lookItems.remove(at: index)
            item.removeFromSuperview()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func clearImages() {
        for item in lookItems {
            item.removeFromSuperview()
        }
        lookItems.removeAll()
    }
    
    func add(image: UIImage?) {
        let item = UIImageView(image: image)
        item.frame = CGRect(x: view.bounds.midX - widthItem/2, y: view.bounds.midY - heightItem/2, width: widthItem, height: heightItem)
        item.contentMode = .scaleAspectFit
        setupItem(item: item)
        lookItems.append(item)
    }

}
        
