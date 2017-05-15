//
//  UIImageView+imageWithURL.swift
//  EtsyTools
//
//  Created by Jeff Eom on 2017-05-14.
//  Copyright © 2017 Jeff Eom. All rights reserved.
//

import UIKit

extension UIImageView {
  public func imageFromURL(urlString: String) {
    
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
      
      if let error = error {
        print(error)
        return
      }
      DispatchQueue.main.async(execute: { () -> Void in
        let image = UIImage(data: data!)
        self.image = image
      })
      
    }).resume()
  }
}
