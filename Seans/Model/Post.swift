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
    var repliesPost: [NewPost] = []
    
    // MARK: Basic User Info
    var userName: String
    var userUID: String
    var userProfileURL: URL?
    var userFirstName: String
    var userLastName: String
    
    //MARK: Actor
    var actorName: String
    var actorID: Int
    var actorPhoto: String
    
    //MARK: Photo
    var postPhoto: String
    
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
        case actorName
        case actorID
        case actorPhoto
        case postPhoto
    }
}
