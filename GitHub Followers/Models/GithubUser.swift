//
//  GithubUser.swift
//  GitHub Followers
//
//  Created by Pritesh Desai on 5/1/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import Foundation

//struct to store the required data
struct User: Codable {
    var login: String?
    var avatar_url: String?
    var name: String?
    var location: String?
    var email: String?
    var public_repos: Int?
    var followers: Int?
    var following: Int?
}



//downloads and returns the data for a single user when given a username
func downloadUserData(for urlString: String, onFinished: @escaping (_: User)-> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
        guard let userUrl = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: userUrl) { (data, response, error) in
            guard let jsonData = data else { return }
            do {
                let _user = try JSONDecoder().decode(User.self, from: jsonData)
                
                DispatchQueue.main.async {
                    onFinished(_user)
                }
            }
            catch { print(error) }
            }.resume()
    } //end dispatch async
}

