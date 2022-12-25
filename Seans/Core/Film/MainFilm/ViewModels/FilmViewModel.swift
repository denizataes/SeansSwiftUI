//
//  FilmViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 14.12.2022.
//

import Foundation
import TMDBSwift


class FilmViewModel: ObservableObject{
    let service = FilmService()
    @Published var popularMovies = [Movie]()
    @Published var nowPlayingMovies = [Movie]()
    @Published var trailers = [Videos]()
    @Published var collections = [Movie]()
    
    init()
    {
        fetchPopularMovies()
        fetchNowPlayingMovies()
    }
    func fetchPopularMovies()
    {
        service.fetchPopularMovies { movies in
            self.popularMovies = movies
        }
    }
    
    func fetchNowPlayingMovies()
    {
        service.fetchNowPlaying { movies in
            self.nowPlayingMovies = movies
        }
    }
    
    func fetchCollection(id: Int)
    {
        service.fetchFilmCollections(id: id) { movies in
            self.collections = movies
        }
        
    }
}
