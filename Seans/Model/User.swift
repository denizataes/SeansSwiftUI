import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable,Codable{
    
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var userName: String
    var userBio: String
    var userUID: String
    var userEmail: String
    var password: String
    var instagramProfileURL: String
    var twitterProfileURL: String
    var userProfileURL: String
    var userProfilePicData: Data?
    var follow: [String]
    var follower: [String]
    var createdDate: Date = Date()
    var updatedDate: Date
    
    init(firstName: String, lastName: String, userName: String, userBio: String, userUID: String, userEmail: String, password: String, instagramProfileURL: String, twitterProfileURL: String, userProfileURL: String, userProfilePicData: Data?, follow: [String], follower: [String], updatedDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.userBio = userBio
        self.userUID = userUID
        self.userEmail = userEmail
        self.password = password
        self.instagramProfileURL = instagramProfileURL
        self.twitterProfileURL = twitterProfileURL
        self.userProfileURL = userProfileURL
        self.userProfilePicData = userProfilePicData
        self.follow = follow
        self.follower = follower
        self.updatedDate = updatedDate
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = ""
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        userName = try container.decode(String.self, forKey: .userName)
        userBio = try container.decode(String.self, forKey: .userBio)
        userUID = try container.decode(String.self, forKey: .userUID)
        userEmail = try container.decode(String.self, forKey: .userEmail)
        instagramProfileURL = try container.decode(String.self, forKey: .instagramProfileURL)
        twitterProfileURL = try container.decode(String.self, forKey: .twitterProfileURL)
        userProfileURL = try container.decode(String.self, forKey: .userProfileURL)
        follower = try container.decode([String].self, forKey: .follower)
        follow = try container.decode([String].self, forKey: .follow)
        createdDate = try container.decode(Date.self, forKey: .createdDate)
        updatedDate = try container.decode(Date.self, forKey: .updatedDate)
        userProfilePicData = nil // Bu alan Decode edilmeyecek
        password = "" // Bu alan Decode edilmeyecek
    }

    
    enum CodingKeys: CodingKey{
        case id
        case firstName
        case lastName
        case userName
        case userBio
        case userUID
        case password
        case userEmail
        case instagramProfileURL
        case twitterProfileURL
        case userProfileURL
        case userProfilePicData
        case follow
        case follower
        case createdDate
        case updatedDate
    }
    
}
