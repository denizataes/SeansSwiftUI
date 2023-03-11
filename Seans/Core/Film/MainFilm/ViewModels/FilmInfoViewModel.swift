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
                var movieDetail = movie
                DispatchQueue.main.async {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-DD"
                    
                    if let releaseDate = formatter.date(from: movie.releaseDate) {
                        formatter.dateFormat = "dd MMMM yyyy" // Burada, tarihi dd MMMM yyyy formatında biçimlendiriyoruz.
                        let formattedDate = formatter.string(from: releaseDate)
                        movieDetail.releaseDate = formattedDate
                    }
                    
                    strongSelf.movie = movieDetail
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


