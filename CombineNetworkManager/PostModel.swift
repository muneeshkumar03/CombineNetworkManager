//
//  PostModel.swift
//  CombineNetworkManager
//
//  Created by Muneesh Kumar on 26/01/25.
//

import Foundation

// MARK: - Post
struct Post: Decodable, Identifiable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
