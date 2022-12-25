//
//  TrailersViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 25.12.2022.
//

import Foundation
import TMDBSwift


class TrailersViewModel: ObservableObject{
    let service = FilmService()
    @Published var trailers = [Videos]()
    var id: Int

    init(id: Int)
    {
        self.id = id
        fetchFilmTrailer()
    }
    
    func fetchFilmTrailer(){
        service.fetchFilmTrailers(id: id) { trailers in
            self.trailers = trailers
        }
    }
    
}




