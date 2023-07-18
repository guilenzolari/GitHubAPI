//
//  GitHubAPIModel.swift
//  GitHub API
//
//  Created by Guilherme Ferreira Lenzolari on 17/07/23.
//

import Foundation

struct GitHubUser: Codable{
    let login: String
    let avatarUrl: String
    let bio: String
    let company: String
    let location: String
    let name: String
}
