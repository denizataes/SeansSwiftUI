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
        MovieMDB.popular(language: "tr", page: 10) { clientReturn, movie in
            if let movie = movie {
                movie.forEach { movie in
                    
                    guard movie.poster_path != nil  else {return} // poster yoksa listeye alma
                    let date = movie.release_date != "" && movie.release_date != nil ? convertDate(dateString: movie.release_date) : ""
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: date, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)
                        completion(movieList)
                
                }
            }
        }
    }
    
    func fetchNowPlaying(completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        MovieMDB.nowplaying(language: "tr", page: 10) { clientReturn, movie in
            if let movie = movie {
                movie.forEach { movie in
                    guard movie.poster_path != nil  else {return} // poster yoksa listeye alma
                    let date = movie.release_date != "" && movie.release_date != nil ? convertDate(dateString: movie.release_date) : ""
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: date, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)

                        completion(movieList)
                    
                    
                }
            }
        }
    }
    
    func fetchTopRated(completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        MovieMDB.toprated(language: "tr", page: 10) { clientReturn, movie in
            if let movie = movie {
                movie.forEach { movie in
                    
                    guard movie.poster_path != nil  else {return} // poster yoksa listeye alma
                    let date = movie.release_date != "" && movie.release_date != nil ? convertDate(dateString: movie.release_date) : ""
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: date , movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)
    
                        completion(movieList)
                    
                    
                }
            }
        }
    }
    
    func fetchUpComing(completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        
        MovieMDB.upcoming(page: 10,language: "tr") { clientReturn, movie in
            
            if let movie = movie {
                movie.forEach { movie in
                    
                    guard movie.poster_path != nil  else {return} // poster yoksa listeye alma
                    let date = movie.release_date != "" && movie.release_date != nil ? convertDate(dateString: movie.release_date) : ""
                    var mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: date, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")

                        completion(movieList)
                    movieList.append(mov)

                    
                }
            }
        }
    }
    
    func searchMovies(query: String, completion: @escaping([Movie]) -> Void){
        var movieList = [Movie]()
        SearchMDB.movie(query: query, language: "tr" , page: 1, includeAdult: true, year: nil, primaryReleaseYear: nil) { clientReturn, movie in
            if let movie = movie{
                movie.forEach { MovieMDB in
                    guard let poster = MovieMDB.poster_path  else {return} // poster yoksa listeye alma
                    let date = MovieMDB.release_date != "" && MovieMDB.release_date != nil ? convertDate(dateString: MovieMDB.release_date) : ""
                    var mov = Movie(id: MovieMDB.id, movieTitle: MovieMDB.title ?? "", releaseDate: date , movieTime: "2 saat", movieDescription: MovieMDB.overview ?? "", artwork: poster)
                    movieList.append(mov)
                        completion(movieList)
                    
                    
                }
            }
            
            
        }
    }
    
    func convertDate(dateString: String?) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString!)
        let formatted = date?.formatted(
            .dateTime
                .day().month(.twoDigits).year()
        )
        return formatted ?? ""
    }
    
    
    func getActorsWithMovieID(with id: Int, completion: @escaping ([Actor]?) -> Void){
        var actorList = [Actor]()
        MovieMDB.credits(movieID: id) { clientReturn, credits in
            
            if let credits = credits{
                
                credits.cast?.forEach { item in
                    
                    guard item.profile_path != nil  else {return} // poster yoksa listeye alma
                    
                    let actorItem = Actor(id: item.id, character: item.character, profile_path: item.profile_path ?? "", name: item.name, order: item.order)
                    
                    actorList.append(actorItem)
                }
            }
            
            completion(actorList)
            
        }
    }
    
    func getSimilarWithMovieID(with id: Int, completion: @escaping ([Movie]) -> Void){
        var movieList = [Movie]()
        
        MovieMDB.similar(movieID: id, page: 10, language: "tr") { clientReturn, movie in
            if let movie = movie {
                
                movie.forEach { movie in
                    
                    guard movie.poster_path != nil  else {return} // poster yoksa listeye alma
                    let date = movie.release_date != "" && movie.release_date != nil ? convertDate(dateString: movie.release_date) : ""
                    let mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: date, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                    movieList.append(mov)
                    completion(movieList)

                }
            }
        }
        
    }
    func fetchActorMovies(with id: Int, completion: @escaping ([Movie]) -> Void){
        var movieList = [Movie]()
        
        PersonMDB.movie_credits(personID: id, language: "tr") { clientReturn, data in
            if let data = data{
                data.cast.forEach({ movieCredits in
                    let group = DispatchGroup()
                    group.enter()
                    DispatchQueue.global(qos: .userInitiated).async {
                        MovieMDB.movie(movieID: movieCredits.id) { clientReturn, movie in
                            if let movie = movie{
                                guard movie.poster_path != nil  else {return} // poster yoksa listeye alma
                                let date = movie.release_date != "" && movie.release_date != nil ? convertDate(dateString: movie.release_date) : ""
                                let mov = Movie(id: movie.id, movieTitle: movie.title ?? "", releaseDate: date, movieTime: "2 saat", movieDescription: movie.overview ?? "", artwork: movie.poster_path ?? "")
                                movieList.append(mov)
                                group.leave()
                            }
                        }
                    }
                    group.notify(queue: .main, execute: {
                        completion(movieList)
                    })
                    
                })
                
            }
            
        }
    
    }

    
}
