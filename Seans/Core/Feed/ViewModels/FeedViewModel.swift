//
//  ActorViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class FeedViewModel: ObservableObject{
    
    @Published var posts: [Post]?
    @Published var isLoading = false
    let dbManager = DatabaseManager()
    @AppStorage("user_UID") var userUID: String = ""
    @Published var paginationDoc: QueryDocumentSnapshot?
    
    init(){
        fetchPosts()
    }
    
    func fetchPosts(){
        guard userUID != "" else{return}
        isLoading = true
        dbManager.fetchFollowerIDs {[weak self] posts in
            guard let strongSelf = self else{return}
            let sortedPosts = posts?.sorted(by: { $0.publishedDate > $1.publishedDate })
            strongSelf.posts = sortedPosts
            strongSelf.isLoading = false
        }
    }
    
}
