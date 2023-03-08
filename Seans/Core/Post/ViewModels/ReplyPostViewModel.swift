//
//  ReplyPostViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import SwiftUI

class ReplyPostViewModel: ObservableObject{
    @AppStorage("user_UID") var userUID: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    @Published var replyPosts: [Post] = []
    
    let dbManager = DatabaseManager()
    
    init(postID: String){
        fetchReplyPosts(postID: postID)
    }
    
    func fetchReplyPosts(postID: String){
        dbManager.fetchReplyPosts(postID: postID) {[weak self] replyPosts in
            guard let strongSelf = self else{return}
            if let repPosts = replyPosts{
                let sortedPosts = replyPosts?.sorted(by: { $0.publishedDate > $1.publishedDate })
                
                strongSelf.replyPosts = sortedPosts ?? []
            }
        }
    }
    
    func replyPost(postID: String, post: NewPost, completion: @escaping (Result<NewPost, Error>) -> Void) {
        isLoading = true
        guard userUID != "" else{return}
        dbManager.replyPost(postID: postID, post: post) {[weak self] result in
            guard let strongSelf = self else{return}
            switch result{
            case .success(()):
                strongSelf.isLoading = false
                completion(.success(post))
            case .failure(let error):
                strongSelf.isLoading = false
                strongSelf.errorMessage = error.localizedDescription
                strongSelf.showError = true
                completion(.failure(error))
            }
        }
    }
    
    func deletePost(postID: String){
        dbManager.deletePost(postID: postID)
    }
    
    
}
