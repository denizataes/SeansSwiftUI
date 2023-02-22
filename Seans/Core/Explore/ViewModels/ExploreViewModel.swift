//
//  ExploreViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.12.2022.
//

import Foundation
class ExploreViewModel: ObservableObject{
    @Published var output: String = ""
    @Published var input: String = ""
    @Published var typing = false
    @Published var searchableUsers = [User]()
    
    var popularMovies = [Movie]()
    var searchableMovies = [Movie]()
    let service = FilmService()
    let dbManager = DatabaseManager()
    
    
    
    
    var searchableFilms: [Movie]{
        if input.isEmpty{
            return popularMovies
        }
        else{
             searchMovies { movies in
                 self.searchableMovies = movies
            }
            return self.searchableMovies
        }
        
    }
    
    init(){
        fetchPopularMovies()
    }
    func fetchPopularMovies(){
        service.fetchPopularMovies { movie in
            self.popularMovies = movie
        }
    }
    
    func searchMovies(completion: @escaping([Movie]) -> Void){
        service.searchMovies(query: input) { movies in
            completion(movies)
        }
    }
    
    func searchUsers(){
        searchableUsers = []
        guard input != "" , input.count > 2 else {return}
        dbManager.searchUsers(query: input.lowercased()) {[weak self] users, error in
            guard error == nil else{return}
            guard let users = users else{return}
            guard let strongSelf = self else{return}
            strongSelf.searchableUsers = users
        }
    }
}
