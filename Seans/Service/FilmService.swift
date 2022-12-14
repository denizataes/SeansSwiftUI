//
//  FilmService.swift
//  Seans
//
//  Created by Deniz Ata Eş on 14.12.2022.
//

import Foundation
import TMDBSwift

struct FilmService{
    init()
    {
        TMDBConfig.apikey = "066cd92637346c12593cd4a8543c8fe2"
    }
    
    func fetchPopularMovies(completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        MovieMDB.popular(page: 20) { clientReturn, movie in
            if let movie = movie {
                movie.forEach { movie in
                    guard let poster = movie.poster_path  else {return} // poster yoksa listeye alma
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: movie.release_date!, movieTime: "2 saat", movieDescription: movie.original_title ?? "", artwork: movie.poster_path ?? "")

                    movieList.append(mov)
                }
                completion(movieList)
            }
        }
    }
    
    func fetchNowPlaying(completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        MovieMDB.nowplaying(page: 20) { clientReturn, movie in
            if let movie = movie {
                movie.forEach { movie in
                    guard let poster = movie.poster_path  else {return} // poster yoksa listeye alma
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: movie.release_date!, movieTime: "2 saat", movieDescription: movie.original_title ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)
                
                }
                completion(movieList)
            }
        }
    }
    
}
