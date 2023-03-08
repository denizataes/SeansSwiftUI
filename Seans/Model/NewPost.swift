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
    var movieID: Int
    var movieName: String
    var moviePhoto: String
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var repliesPost: [NewPost] = []
    var actorID: Int
    var actorName: String
    var actorPhoto: String
    
    // MARK: Basic User Info
    var userUID: String
    
    var postImageData: Data?
    var postPhoto: String

    enum CodingKeys: CodingKey{
        case id
        case text
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
        case postImageData // veri tabanına kaydetmemeli
        case postPhoto
    }
}

struct PostWithUID {
    let post: Post
    let userUID: String
}

