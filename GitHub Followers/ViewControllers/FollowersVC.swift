//
//  ViewController.swift
//  GitHub Followers
//
//  Created by Pritesh Desai on 5/1/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//
// Icons thanks to - https://dribbble.com/shots/1278715-Github-Mac-App-Icon

import UIKit



class FollowersVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    //MARK: - Outlets and Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //we store all the followers for the give user here
    var searchedUsersFollowers: [GithubFollowers] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //apply a pattern to the collection view
        collectionView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "palm-leaf"))
    }
    
    
    
    
    //MARK: - Collection view methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedUsersFollowers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            as? FollowerCollectionViewCell else { fatalError() }
        
        //set follower's name
        cell.username.text = searchedUsersFollowers[indexPath.row].login
        
        //set the avatar image and download it asynchronously
        let avatarUrl = searchedUsersFollowers[indexPath.row].avatar_url
        cell.avatar.setCustomImage(avatarUrl)
        return cell
    }
    
    
    
    
    
    
    //MARK: - Search bar methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //hide the keyboard
        searchBar.resignFirstResponder()
        
        let username = searchBar.text!
        updateView(for: username)
    
    } //end searchBarSearchButtonClicked
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //hide the keyboard
        searchBar.resignFirstResponder()
        
        //reset the datasource
        searchedUsersFollowers.removeAll()
        collectionView.reloadData()
    }
    
    
    
    
    
    //this method downloads the relevant data and reloads the collection view
    func updateView(for username: String) {
        //reset the datasource
        searchedUsersFollowers.removeAll()
        
        downloadFollowers(for: username, onFinished: { [weak self] followers in
            self?.searchedUsersFollowers = followers
            self?.collectionView.reloadData()
        }) //end downloadFollowers
    }
    
    
    
    //MARK: - Navigation    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let indexPath = collectionView.indexPathsForSelectedItems?.first {
            let selectedUser = indexPath.row
            if segue.destination is FollowerDetailsVC
            {
                let vc = segue.destination as? FollowerDetailsVC
                vc?.userUrl = searchedUsersFollowers[selectedUser].url
            }
        }
    }

    
}


