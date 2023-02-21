//
//  ActorViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import SwiftUI

class PostRowViewModel: ObservableObject{
    @AppStorage("user_UID") var userUID: String = ""
    let dbManager = DatabaseManager()
    func likePost(postID: String, isLiked: Bool){
        guard userUID != "" else{return}
        dbManager.likePost(postID: postID, userUID: userUID, isLiked: isLiked)
    }
    
    func deletePost(postID: String){
        dbManager.deletePost(postID: postID)
    }
    
    
}
