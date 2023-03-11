//
//  ActorViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject{
    
    @Published var isLoading = false
    @Published var posts: [Post]?
    @Published var user: User?
    @Published var likedPosts: [Post]?
    @Published var fetched: Int = 0
    
    let dbManager = DatabaseManager()
    @AppStorage("user_UID") var userUID: String = ""
    
    init(userUID: String){
        fetchUser(userUID: userUID)
        fetchPost(userUID: userUID)
        fetchLikedPost(userUID: userUID)
    }
    
    func followUser(currentUserUID: String, followUserID: String, isFollow: Bool, completion: @escaping (Bool) -> Void) {
//        dbManager.followUser(currentUserID: currentUserUID, followUserID: followUserID, isFollow: isFollow)
        dbManager.followUser(currentUserID: currentUserUID, followUserID: followUserID, isFollow: isFollow) { res in
            if res{
                completion(true)
            }
            else{
                completion(false)
            }
        }
    }
    
    func fetchUser(userUID: String){
        dbManager.fetchUser(withUid: userUID) {[weak self] user in
            guard let strongSelf = self else{return}
            guard let user = user else{return}
            strongSelf.user = user
            strongSelf.fetched += 1
        }
    }
    
    func fetchPost(userUID: String){
        
        dbManager.fetchAllPosts(userUIDs: [userUID]) {[weak self] posts in
            guard let strongSelf = self else{return}
            let sortedPosts = posts?.sorted(by: { $0.publishedDate > $1.publishedDate })
            strongSelf.posts = sortedPosts
            strongSelf.fetched += 1
        }
    }
    
    func fetchLikedPost(userUID: String){
        
        dbManager.fetchLikedPosts(userUID: userUID) {[weak self] posts in
            guard let strongSelf = self else{return}
            let sortedPosts = posts?.sorted(by: { $0.publishedDate > $1.publishedDate })
            strongSelf.likedPosts = sortedPosts
            strongSelf.fetched += 1
        }
    }
    
}
