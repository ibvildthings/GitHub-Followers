//
//  FollowerCollectionViewCell.swift
//  GitHub Followers
//
//  Created by Pritesh Desai on 5/1/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //avatar in a circle
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
    }
}
