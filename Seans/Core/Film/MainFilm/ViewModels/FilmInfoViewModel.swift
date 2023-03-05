//
//  FilmInfoViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//
import Foundation

class FilmInfoViewModel: ObservableObject {
    
    let service = FilmService()
    @Published var movie: MovieDetail?
    
    init(movieID: Int){
        fetchMovie(id: movieID)
    }
    
    func fetchMovie(id: Int){
        service.fetchMovieDetail(movieID: id) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    strongSelf.movie = movie
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


