//
//  CustomeUIImageViewClass.swift
//  Stretchy Effect
//
//  Created by Arjun Kodur on 11/13/16.
//  Copyright © 2016 Arjun Kodur. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(_ urlString: String) {
        
        imageUrlString = urlString
        
        image = nil
        
        //Checking for Cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        //Download request using Alamofire
        Alamofire.request(urlString).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                
                let imageToCache = image
                
                if self.imageUrlString == urlString {
                    DispatchQueue.main.async {
                       self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                }
            }
        }
    
    }
    
}
