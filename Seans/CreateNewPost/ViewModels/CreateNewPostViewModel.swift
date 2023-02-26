//
//  ActorViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import SwiftUI

class CreatePostViewModel: ObservableObject{
    
    let dbManager = DatabaseManager()
    @Published var isLoading = false

    func createPost(post: NewPost, completion: @escaping (Result<NewPost, Error>) -> Void) {
        isLoading = true
        
        dbManager.createPost(post) {[weak self] result in
            guard let strongSelf = self else {return}
            strongSelf.isLoading = false
            switch result{
            case .success(()):
                completion(.success(post))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
