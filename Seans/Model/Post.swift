//
//  Post.swift
//  SocialMediaApp
//
//  Created by Deniz Ata Eş on 13.02.2023.
//

import SwiftUI
import FirebaseFirestoreSwift

// MARK: Post Model

struct Post: Identifiable, Codable, Equatable{
    
    @DocumentID var id: String?
    var text: String
    var imageURL: URL?
    var movieID: Int
    var movieName: String
    var moviePhoto: String
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var repliesPost: [Post] = []
    
    // MARK: Basic User Info
    var userName: String
    var userUID: String
    var userProfileURL: URL
    var userFirstName: String
    var userLastName: String
    
    enum CodingKeys: CodingKey{
        case id
        case text
        case imageURL
        case repliesPost
        case movieID
        case movieName
        case moviePhoto
        case publishedDate
        case likedIDs
        case userName
        case userUID
        case userProfileURL
        case userFirstName
        case userLastName
    }
}