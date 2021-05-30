//
//  UIImageViewExt.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import UIKit

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, placeHolderImage:UIImage) {
        
        if self.image == nil{
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
