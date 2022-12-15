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
        MovieMDB.popular(page: 10) { clientReturn, movie in
            if let movie = movie {
                movie.forEach { movie in
                    
                    guard let poster = movie.poster_path  else {return} // poster yoksa listeye alma
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: movie.release_date!, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)
                }
                completion(movieList)
            }
        }
    }
    
    func fetchNowPlaying(completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        MovieMDB.nowplaying(page: 10) { clientReturn, movie in
            if let movie = movie {
                movie.forEach { movie in
                    guard let poster = movie.poster_path  else {return} // poster yoksa listeye alma
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: movie.release_date!, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)
                
                }
                completion(movieList)
            }
        }
    }
    
    func fetchTopRated(completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        MovieMDB.toprated(page: 10) { clientReturn, movie in
            if let movie = movie {
                movie.forEach { movie in
                
                    guard let poster = movie.poster_path  else {return} // poster yoksa listeye alma
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: movie.release_date!, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)
                
                }
                completion(movieList)
            }
        }
    }
    
    func fetchUpComing(completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        
        MovieMDB.upcoming(page: 10) { clientReturn, movie in
            
            if let movie = movie {
                movie.forEach { movie in
                
                    guard let poster = movie.poster_path  else {return} // poster yoksa listeye alma
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: movie.release_date!, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)
                
                }
                completion(movieList)
            }
        }
    }
    
    func searchMovies(query: String, completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        
        SearchMDB.movie(query: query, language: "en" , page: 1, includeAdult: true, year: nil, primaryReleaseYear: nil) { clientReturn, movie in
            if let movie = movie{
                movie.forEach { MovieMDB in
                    var mov = Movie(id: MovieMDB.id, movieTitle: MovieMDB.title ?? "", releaseDate: MovieMDB.release_date!, movieTime: "2 saat", movieDescription: MovieMDB.overview ?? "", artwork: MovieMDB.poster_path ?? "")
                    movieList.append(mov)
                }
            }
            completion(movieList)
        }
        
//        SearchMDB.movie(query: query) { clientReturn, movie in
//            if let movie = movie{
//                movie.forEach { MovieMDB in
//                    var mov = Movie(id: MovieMDB.id, movieTitle: MovieMDB.title ?? "", releaseDate: MovieMDB.release_date!, movieTime: "2 saat", movieDescription: MovieMDB.overview ?? "", artwork: MovieMDB.poster_path ?? "")
//                    movieList.append(mov)
//                }
//            }
//        completion(movieList)
    }
}
