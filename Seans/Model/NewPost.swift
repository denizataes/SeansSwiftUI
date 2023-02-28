//
//  Post.swift
//  SocialMediaApp
//
//  Created by Deniz Ata Eş on 13.02.2023.
//

import SwiftUI
import FirebaseFirestoreSwift

// MARK: Post Model

struct NewPost: Identifiable, Codable, Equatable{
    
    @DocumentID var id: String?
    var text: String
    var imageURL: URL?
    var movieID: Int
    var movieName: String
    var moviePhoto: String
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var repliesPost: [Post] = []
    var actorID: Int
    var actorName: String
    var actorPhoto: String
    
    // MARK: Basic User Info
    var userUID: String

    enum CodingKeys: CodingKey{
        case id
        case text
        case imageURL
        case movieID
        case movieName
        case moviePhoto
        case publishedDate
        case likedIDs
        case userUID
        case repliesPost
        case actorID
        case actorName
        case actorPhoto
    }
}

struct PostWithUID {
    let post: Post
    let userUID: String
}

