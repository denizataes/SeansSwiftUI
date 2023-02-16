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
    var snapchatProfileURL: String
    var tiktokProfileURL: String
    var youtubeProfileURL: String
    var userProfileURL: String
    var userProfilePicData: Data?
    
    init(firstName: String, lastName: String, userName: String, userBio: String, userUID: String, userEmail: String, password: String, instagramProfileURL: String, twitterProfileURL: String, snapchatProfileURL: String, tiktokProfileURL: String, youtubeProfileURL: String, userProfileURL: String, userProfilePicData: Data?) {
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.userBio = userBio
        self.userUID = userUID
        self.userEmail = userEmail
        self.password = password
        self.instagramProfileURL = instagramProfileURL
        self.twitterProfileURL = twitterProfileURL
        self.snapchatProfileURL = snapchatProfileURL
        self.tiktokProfileURL = tiktokProfileURL
        self.youtubeProfileURL = youtubeProfileURL
        self.userProfileURL = userProfileURL
        self.userProfilePicData = userProfilePicData
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
        snapchatProfileURL = try container.decode(String.self, forKey: .snapchatProfileURL)
        tiktokProfileURL = try container.decode(String.self, forKey: .tiktokProfileURL)
        youtubeProfileURL = try container.decode(String.self, forKey: .youtubeProfileURL)
        userProfileURL = try container.decode(String.self, forKey: .userProfileURL)
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
        case snapchatProfileURL
        case tiktokProfileURL
        case youtubeProfileURL
        case userProfileURL
        case userProfilePicData
    }
    
}
