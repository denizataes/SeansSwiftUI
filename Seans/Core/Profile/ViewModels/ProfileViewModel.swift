//
//  ActorViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject{
    @Published var posts: [Post]?
    @Published var user: User?
    let dbManager = DatabaseManager()
    @AppStorage("user_UID") var userUID: String = ""
    
    init(userUID: String){
        fetchUser(userUID: userUID)
        fetchPost(userUID: userUID)
    }
    
    func followUser(currentUserUID: String, followUserID: String, isFollow: Bool){
        dbManager.followUser(currentUserID: currentUserUID, followUserID: followUserID, isFollow: isFollow)
    }
    
    func fetchUser(userUID: String){
        dbManager.fetchUser(withUid: userUID) {[weak self] user in
            guard let strongSelf = self else{return}
            guard let user = user else{return}
            strongSelf.user = user
            print(user.follower)
        }
    }
    
    func fetchPost(userUID: String){
        
        dbManager.fetchPosts(withUid: userUID) {[weak self] posts in
            guard let strongSelf = self else{return}
            let sortedPosts = posts?.sorted(by: { $0.publishedDate > $1.publishedDate })
            strongSelf.posts = sortedPosts
        }
    }
    
}
