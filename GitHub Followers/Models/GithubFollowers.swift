//
//  GithubFollowers.swift
//  GitHub Followers
//
//  Created by Pritesh Desai on 5/1/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import Foundation

struct GithubFollowers: Codable {
    var login: String?
    var avatar_url: String?
    var url: String?
}



//downloads and returns an array of all the followers for a given user
func downloadFollowers(for username: String, onFinished: @escaping (_: [GithubFollowers])-> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
        guard let usersFollowersUrl = URL(string: "https://api.github.com/users/" + username + "/followers") else { return }
        print(usersFollowersUrl)
        URLSession.shared.dataTask(with: usersFollowersUrl) { (data, response, error) in
            guard let jsonData = data else { return }
            do {
                let followers = try JSONDecoder().decode([GithubFollowers].self, from: jsonData)
                
                DispatchQueue.main.async {
                    onFinished(followers)
                }
            }
            catch { print(error) }
            }.resume()
    } //end dispatch async
}
