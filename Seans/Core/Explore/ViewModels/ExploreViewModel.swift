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
    var popularMovies = [Movie]()
    var searchableMovies = [Movie]()
    let service = FilmService()
    
    
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
}
