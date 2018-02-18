//
//  Image.swift
//  Job Hunt
//
//  Created by Raphael on 2/17/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

let imgCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadFromURL(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        
        image = nil
        
        if let cachedImg = imgCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImg
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                print(err!)
                return
            }
            
            DispatchQueue.main.async {
                let img = UIImage(data: data!)
                imgCache.setObject(img!, forKey: urlString as NSString)
                self.image = img
            }
        }.resume()
    }
}
