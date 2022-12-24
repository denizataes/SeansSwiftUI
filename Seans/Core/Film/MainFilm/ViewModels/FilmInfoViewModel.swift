//
//  ActorViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import TMDb

class FilmInfoViewModel: ObservableObject{

    let service = FilmService()
    @Published var movie = MovieDetail()
    
    // Düzenlenecek...
    func fetchMovie(id: Int) async
    {
        let tmdb = TMDbAPI(apiKey: "066cd92637346c12593cd4a8543c8fe2")
        do{
            let movieDB = try await tmdb.movies.details(forMovie: id)
            DispatchQueue.main.async {
            var mov = MovieDetail()
            mov.id = movieDB.id
            mov.runtime = movieDB.runtime
            mov.title = movieDB.title
            mov.tagline = movieDB.tagline
            //mov.status = movieDB.status
            //mov.releaseDate = movieDB.releaseDate
            mov.imdbID = movieDB.imdbID
            print(movieDB)  
                self.movie = mov
              }
        }
        catch{
            print(error.localizedDescription)
        }

     

      //  service.fetchMovieDetail(id: id) { movie in
        //    self.movie = movie
        //}
       
       
    }
    
}
