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
    
    init(){
        fetchUser()
        fetchPost()
    }
    
    func fetchUser(){
        guard userUID != "" else{return}
        dbManager.fetchUser(withUid: userUID) {[weak self] user in
            guard let strongSelf = self else{return}
            guard let user = user else{return}
            strongSelf.user = user
        }
    }
    
    func fetchPost(){
        guard userUID != "" else{return}
        dbManager.fetchPosts(withUid: userUID) {[weak self] posts in
            guard let strongSelf = self else{return}
            strongSelf.posts = posts
        }
    }
    
}
