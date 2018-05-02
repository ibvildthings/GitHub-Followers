//
//  Utilities.swift
//  GitHub Followers
//
//  Created by Pritesh Desai on 5/1/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//
// Collection of utility functions used in the app

import UIKit



//utility function to download images async
extension UIImageView {
    
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "github-default-avatar.png")
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : UIImage(named: "github-default-avatar.png")
            }
        }
    }
    
}

