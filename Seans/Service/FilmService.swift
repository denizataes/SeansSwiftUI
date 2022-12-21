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
        
        
//        GenresMDB.genres(listType: .movie, language: "tr"){
//          apiReturn, genres in
//          if let genres = genres{
//            genres.forEach{
//
//            }
//          }
//        }
        
//        MovieMDB.movie(movieID: 674919, language: "en"){
//             apiReturn, movie in
//             if let movie = movie{
//                 print(movie.production_companies)
//                 print(movie.)
//               print(movie.title)
//               print(movie.revenue)
//                 print(movie.belongs_to_collection)
//                 print(movie.budget)
//                 print(movie.imdb_id)
//                 print(movie.homepage)
//                 print(movie.runtime)
//                 print(movie.status)
//                 print(movie.tagline)
//                 print(movie.overview)
//                 print(movie.genre_ids)
//
////               print(movie.genres[0].name)
//                 movie.production_companies?.forEach({ item in
//                     print(item.name)
//                 })
//             }
//           }
        
//        MovieMDB.keywords(movieID: 27275){
//          apiReturn, keywords in
//          if let keywords = keywords{
//              keywords.forEach { item in
//                  print(item.name)
//              }
//        }
//        }
//
        
        
    //        MovieMDB.release_dates(movieID: 27275){
    //              apiReturn, dates in
    //              if let releaseDates = dates{
    //                for releaseDate in releaseDates{
    //                  print(releaseDate.iso_3166_1)
    //                  print(releaseDate.release_dates[0].certification)
    //                  print(releaseDate.release_dates[0].iso_639_1 ?? "") //possible nil value
    //                  print(releaseDate.release_dates[0].note ?? "") //possible nil value
    //                  print(releaseDate.release_dates[0].release_date)
    //                  print(releaseDate.release_dates[0].type)
    //                }
    //              }
    //            }
        
//
//        MovieMDB.list(movieID: 27275, page: 1, language: "tr"){
//            apiReturn, lists in
//            if let lists  = lists{
//                for list in lists{
//                    print(list.name!)
//                    print(list.description)
//                    print(list.item_count)
//                }
//            }
//        }
//
//        MovieMDB.reviews(movieID: 27275, page: 1, language: "en"){
//             data, reviews in
//            if let reviews = reviews{
//                reviews.forEach { item in
//                    print(item.content)
//
//                }
//            }
//           }
//
        
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
    
    func fetchFilmTrailers(id: Int, completion: @escaping ([Videos]) -> Void){
        var videoList = [Videos]()
        MovieMDB.videos(movieID: id, language: "tr"){
           apiReturn, videos in
           if let videos = videos{
               videos.forEach { video in
                   guard video.site == "YouTube" else {return}
                   let vid = Videos(id: video.id, key: video.key, site: video.site, size: video.size, type: video.type)
                   videoList.append(vid)
               }
           }
            completion(videoList)
         }

    }
}
