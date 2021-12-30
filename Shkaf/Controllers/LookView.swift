//
//  LookView.swift
//  Shkaf
//
//  Created by Ума Мирзоева on 25.12.2021.
//

import UIKit

class LookView: UIView {
    
    // MARK: - Properties
    
    var lookItems = [UIImageView]()
    var alertCompletion: ((UIViewController) -> Void)?
    
    // MARK: - Public
    
    func addNewClother(image: UIImageView) {
        image.frame = CGRect(x: bounds.midX - Constants.ItemImageSize.widthItem/2, y: bounds.midY - Constants.ItemImageSize.heightItem/2, width: Constants.ItemImageSize.widthItem, height: Constants.ItemImageSize.heightItem)
        image.contentMode = .scaleAspectFit
        setupItem(item: image)
        lookItems.append(image)
    }
    
    func clearImages() {
        for item in lookItems {
            item.removeFromSuperview()
        }
        lookItems.removeAll()
    }
    
    func uploadFrames() -> [CGRect] {
        return lookItems.map { item in
            return CGRect(
                x: item.frame.minX / self.frame.width,
                y: item.frame.minY / self.frame.height,
                width: item.frame.width / self.frame.width,
                height: item.frame.height / self.frame.height
            )
        }
    }
    
    // MARK: - Private
    
    private func setupItem(item: UIImageView) {
        item.layer.borderColor = UIColor.red.cgColor
        item.layer.borderWidth = 1.0
        self.addSubview(item)
        
        let scaleRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(scaleHandler(gestureRecognizer:)))
        let fingerRecognizer = UIPanGestureRecognizer(target: self, action: #selector(fingerHandler(recognizer:)))
        let tappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedHandler(tapRecognizer:)))
        let deleteItemRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(pressRecognizer:)))
        
        item.addGestureRecognizer(deleteItemRecognizer)
        self.addGestureRecognizer(scaleRecognizer)
        item.isUserInteractionEnabled = true
        item.addGestureRecognizer(fingerRecognizer)
        item.addGestureRecognizer(tappedRecognizer)        
    }
    
    @objc private func scaleHandler(gestureRecognizer: UIPinchGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        
        let firstTouchPoint = gestureRecognizer.location(ofTouch: 0, in: view)
        guard let item = view.subviews.last(where: { subview in
            subview.frame.contains(firstTouchPoint)
        }) else { return }
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let tmpScale = gestureRecognizer.scale > 1 ? gestureRecognizer.scale : -gestureRecognizer.scale
            let newFrame = CGRect(
                x: item.frame.minX - tmpScale,
                 y: item.frame.minY - tmpScale,
                width: item.frame.width * gestureRecognizer.scale,
                height: item.frame.height * gestureRecognizer.scale
            )
            if bounds.contains(newFrame) {
                item.frame = newFrame
                gestureRecognizer.scale = 1.0
            }
        }
    }
    
    @objc private func fingerHandler(recognizer: UIPanGestureRecognizer) {
        guard let item = recognizer.view else { return }
        let translation = recognizer.translation(in: self)
        let newFrame = CGRect(
            x: item.center.x - item.frame.width/2 + translation.x,
            y: item.center.y - item.frame.height/2 + translation.y,
            width: item.frame.width,
            height: item.frame.height
        )
        if bounds.contains(newFrame) {
            item.frame = newFrame
            recognizer.setTranslation(.zero, in: self)
        }
        bringSubviewToFront(item)
    }
    
    @objc private func tappedHandler(tapRecognizer: UITapGestureRecognizer) {
        guard let item = tapRecognizer.view else { return }
        bringSubviewToFront(item)
    }
    
    @objc private func longPressHandler(pressRecognizer: UILongPressGestureRecognizer) {
        let alert = UIAlertController(title: Constants.StringConstants.deleteItemQuestion, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.StringConstants.yes, style: .destructive, handler: { [weak self] _ in
            guard let item = pressRecognizer.view,
                  let index = self?.lookItems.firstIndex(where: { image in image === item }) else { return }
            self?.lookItems.remove(at: index)
            item.removeFromSuperview()
        }))
        alert.addAction(UIAlertAction(title: Constants.StringConstants.cancel, style: .cancel, handler: nil))
        alertCompletion?(alert)
    }

}
        
