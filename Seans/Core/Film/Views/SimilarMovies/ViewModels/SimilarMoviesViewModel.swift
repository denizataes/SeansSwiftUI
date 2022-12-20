//
//  FilmViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 14.12.2022.
//

import Foundation
import TMDBSwift


class SimilarMoviesViewModel: ObservableObject{
    let service = FilmService()
    @Published var similarMovies = [Movie]()
    var id: Int
    init(id: Int)
    {
        self.id = id
        fetchSimilarMovies()
        
    }
    func fetchSimilarMovies()
    {
        service.getSimilarWithMovieID(with: id) { movies in
            self.similarMovies = movies
        }
      
    }

}
