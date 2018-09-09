//
//  UIImageViewExtensions.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class PhotoView : UIImageView {
    
    var imageUrlString : String?
    
    func loadImageUsingUrlString(urlString:String) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        self.image = nil
        
        //Check cache first
        if let imgFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imgFromCache
            return
        }
        self.layer.opacity = 0
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error on req.")
                print(error!)
                return
            }
            guard let imageData = data else {
                print("Error: did not receive data")
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: imageData)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                self.setImageVisibleWithAnimation()
            }
        }
        task.resume()
    }
}

extension PhotoView {
    func changeImage(with secondImage:UIImage)
    {
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");
        fadeAnim.fromValue = self.image
        fadeAnim.toValue   = secondImage
        fadeAnim.duration  = 0.2
        
        self.layer.add(fadeAnim, forKey: "contents");
        self.image = secondImage;
    }
    
    fileprivate func setImageVisibleWithAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.opacity = 1
        }) { (isFinished) in
            if isFinished {
                debugPrint("Image visible")
            }
        }
    }
}
