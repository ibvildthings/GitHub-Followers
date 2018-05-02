//
//  FollowerDetailsVC.swift
//  GitHub Followers
//
//  Created by Pritesh Desai on 5/1/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit

class FollowerDetailsVC: UIViewController {
    
    // MARK: - Outlets and properties
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var publicReposCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var email: UILabel!
    
    //this is used to pass the selected user to this VC
    var userUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //download and display the user's details
        downloadUserData(for: userUrl!) { (user) in
            self.displayUserDetails(for: user)
        }
    }
    
    override func viewDidLayoutSubviews() {
        //avatar in a circle
        avatar.layer.cornerRadius = avatar.frame.height/2
    }
    
    //update the title, labels, backgound and the avatar
    func displayUserDetails(for user: User) {
        //title
        title = (user.name != "") ? user.name : user.login
        
        //avatar
        let avatarUrl = user.avatar_url
        avatar.setCustomImage(avatarUrl)
        
        //other labels
        name.text = user.name
        username.text = user.login
        
        publicReposCount.text = String(user.public_repos!)
        followersCount.text = String(user.followers!)
        followingCount.text = String(user.following!)
        
        location.text = user.location
        email.text = user.email
        
        //change background image
        backgroundImage.setCustomImage(avatarUrl)
    }
    

}
