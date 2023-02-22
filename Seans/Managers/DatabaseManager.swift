//
//  DatabaseManager.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.02.2023.
//

import Foundation
import FirebaseDatabase
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    func insertUser(with user: User, completion: @escaping (Result<(), Error>) -> Void){
        Auth.auth().createUser(withEmail: user.userEmail, password: user.password){ result, error in
            if let error = error {
                print("DEBUG: kayıt aşamasında hata oluştu -> \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let userUID = Auth.auth().currentUser?.uid else {
                print("DEBUG: kayıt aşamasında hata oluştu -> \(error?.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            let data = [
                "userUID": userUID,
                "firstName": user.firstName,
                "lastName": user.lastName,
                "userName": user.userName,
                "userBio": user.userBio,
                "userEmail": user.userEmail,
                "instagramProfileURL": user.instagramProfileURL,
                "twitterProfileURL": user.twitterProfileURL,
                "snapchatProfileURL": user.snapchatProfileURL,
                "tiktokProfileURL": user.tiktokProfileURL,
                "youtubeProfileURL": user.youtubeProfileURL,
                "userProfileURL": user.userProfileURL,
                "follow": [],
                "follower": [],
                "createdDate": user.createdDate,
                "updatedDate": user.updatedDate
            ]
            
            Firestore.firestore().collection("Users").document(userUID).setData(data){ error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let userProfilePicData = user.userProfilePicData {
                    StorageManager.shared.uploadProfilePicture(with: userProfilePicData, userUID: userUID) {[weak self] result in
                        guard let strongSelf = self else { return }
                        switch result {
                        case .success(let url):
                            strongSelf.updateProfilePhoto(with: url, uid: userUID) { updateError in
                                if let updateError = updateError {
                                    completion(.failure(updateError))
                                    return
                                }
                                completion(.success(()))
                            }
                        case .failure(let error):
                            strongSelf.deleteUser()
                            completion(.failure(error))
                        }
                    }
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    func updateProfilePhoto(with url: String, uid: String, completion: ((Error?) -> Void)? = nil) {
        Firestore.firestore().collection("Users").document(uid).updateData(["userProfileURL": url]) { error in
            if let completion = completion {
                completion(error)
            }
        }
    }
    
    func deleteUser(){
        Auth.auth().currentUser?.delete(completion: { error in
            if let error = error{
                print("DEBUG: kullanıcının silinmesi esnasında hata oluştu -> \(error.localizedDescription)")
                return
            }
            guard let uid = Auth.auth().currentUser?.uid else{return}
            Firestore.firestore().collection("Users").document(uid).delete()
        })
    }
    func login(email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else {
                completion(.failure(NSError(domain: "com.example.domain", code: 400, userInfo: [NSLocalizedDescriptionKey: "Authentication failed"])))
                
                return
            }
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let userUID = Auth.auth().currentUser?.uid else {
                completion(.failure(NSError(domain: "com.example.domain", code: 400, userInfo: [NSLocalizedDescriptionKey: "Authentication failed"])))
                return
            }
            
            strongSelf.fetchUser(withUid: userUID) { user in
                completion(.success(user))
            }
        }
    }
    
    public func userExistsWithEmail(_ email: String, completion: @escaping ((Bool) -> Void)) {
        Firestore.firestore().collection("Users")
            .whereField("userEmail", isEqualTo: email)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error checking user existence with email: \(email) - \(error.localizedDescription)")
                    completion(false)
                } else {
                    guard let snapshot = querySnapshot else {
                        completion(false)
                        return
                    }
                    completion(!snapshot.documents.isEmpty)
                }
            }
    }
    
    public func getUserProfileImageURL(with uid: String, completion: @escaping ((String) -> Void)) {
        Firestore.firestore().collection("Users")
            .whereField("userUID", isEqualTo: uid)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting user profile image with uid : \(uid) - \(error.localizedDescription)")
                    completion("")
                } else {
                    guard let snapshot = querySnapshot, let document = snapshot.documents.first else {
                        completion("")
                        return
                    }
                    let profileURL = document.data()["userProfileURL"] as? String ?? ""
                    print("profil fotoğrafı: \(profileURL)")
                    completion(profileURL)
                }
            }
    }
    
    
    
    
    func fetchUser(withUid uid: String, completion: @escaping (User?) -> Void){
        Firestore.firestore().collection("Users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else {
                    completion(nil)
                    return
                }
                
                guard let user = try? snapshot.data(as: User.self) else {
                    completion(nil)
                    return
                }
                
                completion(user)
            }
    }
    
    func saveUser(with user: User, completion: @escaping (Result<(), Error>) -> Void){
        
        let data: [String: Any] = [
            "userUID": user.userUID,
            "firstName": user.firstName,
            "lastName": user.lastName,
            "userName": user.userName,
            "userBio": user.userBio,
            "userEmail": user.userEmail,
            "instagramProfileURL": user.instagramProfileURL,
            "twitterProfileURL": user.twitterProfileURL,
            "snapchatProfileURL": user.snapchatProfileURL,
            "tiktokProfileURL": user.tiktokProfileURL,
            "youtubeProfileURL": user.youtubeProfileURL,
            "userProfileURL": user.userProfileURL,
            "follow": [],
            "follower": [],
            "createdDate": user.createdDate,
            "updatedDate": user.updatedDate
        ]
        
        
        Firestore.firestore().collection("Users").document(user.userUID).setData(data){ error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let userProfilePicData = user.userProfilePicData {
                StorageManager.shared.uploadProfilePicture(with: userProfilePicData, userUID: user.userUID) {[weak self] result in
                    guard let strongSelf = self else { return }
                    switch result {
                    case .success(let url):
                        strongSelf.updateProfilePhoto(with: url, uid: user.userUID) { updateError in
                            if let updateError = updateError {
                                completion(.failure(updateError))
                                return
                            }
                            @AppStorage("user_profile_url") var profileURL: URL?
                            profileURL = URL(string: url)
                            completion(.success(()))
                        }
                    case .failure(let error):
                        strongSelf.deleteUser()
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    func createPost(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let collection = Firestore.firestore().collection("Posts")
            var newPost = post
            newPost.id = nil // Ignore the id field if it's set
            try collection.addDocument(from: newPost) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    
    
    func fetchPosts(withUid uid: String, completion: @escaping ([Post]?) -> Void) {
        let query = Firestore.firestore().collection("Posts").whereField("userUID", isEqualTo: uid)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching posts for user with UID \(uid): \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            let posts = snapshot.documents.compactMap { document -> Post? in
                do {
                    return try document.data(as: Post.self)
                } catch {
                    print("Error decoding post with ID \(document.documentID): \(error.localizedDescription)")
                    return nil
                }
            }
            
            completion(posts)
        }
    }
    
    func likePost(postID: String, userUID: String, isLiked: Bool) {
        let postRef = Firestore.firestore().collection("Posts").document(postID)
        
        if isLiked {
            postRef.updateData(["likedIDs": FieldValue.arrayRemove([userUID])])
        } else {
            postRef.updateData(["likedIDs": FieldValue.arrayUnion([userUID])])
        }
    }
    
    func deletePost(postID: String) {
        let postRef = Firestore.firestore().collection("Posts").document(postID)
        
        postRef.delete { error in
            if let error = error {
                print("Error deleting post: \(error.localizedDescription)")
            } else {
                print("Post with ID \(postID) successfully deleted")
            }
        }
    }
    
    func followUser(currentUserID: String, followUserID: String, isFollow: Bool) {
        let currentUserPostRef = Firestore.firestore().collection("Users").document(currentUserID)
        let followUserPostRef = Firestore.firestore().collection("Users").document(followUserID)
        if isFollow {
            currentUserPostRef.updateData(["follow": FieldValue.arrayRemove([followUserID])])
            followUserPostRef.updateData(["follower": FieldValue.arrayRemove([currentUserID])])
        } else {
            followUserPostRef.updateData(["follower": FieldValue.arrayUnion([currentUserID])])
            currentUserPostRef.updateData(["follow": FieldValue.arrayUnion([followUserID])])
        }
    }
    
    
    func fetchAllPosts(userUIDs: [String], completion: @escaping ([Post]?) -> Void) {
        Firestore.firestore().collection("Posts")
            .whereField("userUID", in: userUIDs)
            .getDocuments { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    completion(nil)
                    return
                }
                
                let posts = snapshot.documents.compactMap { document -> Post? in
                    try? document.data(as: Post.self)
                }
                completion(posts)
            }
    }
    
//    func searchUsers(query: String, completion: @escaping ([User]?, Error?) -> Void) {
//        Firestore.firestore().collection("Users")
//            .whereField("userName", isGreaterThanOrEqualTo: query.lowercased())
//            .whereField("userName", isLessThanOrEqualTo: query.lowercased() + "\u{f8ff}")
//            .whereField("firstName", isGreaterThanOrEqualTo: query.capitalized + "\u{f8ff}")
//            .whereField("lastName", isGreaterThanOrEqualTo: query.capitalized + "\u{f8ff}")
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    completion(nil, error)
//                } else {
//                    let users = snapshot?.documents.compactMap { document in
//                        try? document.data(as: User.self)
//                    }
//                    completion(users, nil)
//                }
//            }
//    }
    func fetchFollowerIDs(completion: @escaping ([Post]?) -> Void) {

        let currentUser = Auth.auth().currentUser
        guard let userUID = currentUser?.uid else{return}
        var followingUserUID = [String]()
        followingUserUID.append(userUID)
        print("Giriş yapan kullanıcı: \(userUID)")
        Firestore.firestore().collection("Users").document(userUID).getDocument {[weak self] snapshot, error in
            guard let strongSelf = self else{return}
            guard let snapshot = snapshot else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            guard let data = snapshot.data() else { return }
            let following = data["follow"] as? [String]
            guard let following = following , following.count >= 1 else {
                completion(nil)
                return
            }
            followingUserUID += following // kendi postlarımı göreyim eğer takip ettiklerim varsa onlarda gelsin.
            print("Takip Ettiğim kullanıcılar: \(following)")
            strongSelf.fetchAllPosts(userUIDs: followingUserUID) { posts in
                completion(posts)
            }
        }

    }
    
    
    
    func searchUsers(query: String, completion: @escaping ([User]?, Error?) -> Void) {
        print("Aratılan değer: \(query)")
        let collectionRef = Firestore.firestore().collection("Users")
        collectionRef
            .whereField("userName", isGreaterThanOrEqualTo: query)
            .whereField("userName", isLessThanOrEqualTo: query + "\u{f8ff}")
            .order(by: "userName")
            .limit(to: 10)
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil,error)
                    return
                }
                guard let documents = snapshot?.documents else {
                    completion(nil,nil)
                    return
                }
                let users = documents.compactMap { document in
                    try? document.data(as: User.self)
                }
                print(users)
                completion(users,nil)
            }
    }




    
}
