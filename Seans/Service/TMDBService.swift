//
//  TMDBService.swift
//  Seans
//
//  Created by Deniz Ata Eş on 25.12.2022.
//

import Foundation
import TMDBSwift
import TMDb


struct TMDBService{
    private let tmdb: TMDbAPI
    init()
    {
        self.tmdb = TMDbAPI(apiKey: "066cd92637346c12593cd4a8543c8fe2")
    }
    
//    func getFilmDetails(id: Int, completion: @escaping(MovieDetail) -> Void) async
//    {
//        do{
//            let movieDB = try await tmdb.movies.details(forMovie: id)
//            DispatchQueue.main.async {
//            var mov = MovieDetail()
//            mov.id = movieDB.id
//            mov.runtime = movieDB.runtime
//            mov.title = movieDB.title
//            mov.tagline = movieDB.tagline
//            mov.homepage = movieDB.homepageURL?.relativeString
//            mov.imdbID = movieDB.imdbID
//            var genreList = [Genre]()
//                
//            movieDB.genres?.forEach({ genre in
//                    var genreModel = Genre()
//                    genreModel.name = genre.name
//                    genreModel.id = genre.id
//                    genreList.append(genreModel)
//            })
//            mov.genres = genreList
//            
//            completion(mov)
//            }
//        }
//        catch{
//            print(error.localizedDescription)
//        }
//
//
//    }
    
}
