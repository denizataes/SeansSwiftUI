//
//  ActorViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import TMDb

class FilmInfoViewModel: ObservableObject{

    let service = TMDBService()
    @Published var movie = MovieDetail()
    
    
    func fetchMovie(id: Int) async
    {
        await service.getFilmDetails(id: id) { movie
            in
            self.movie = movie
        }
    }
    
}
