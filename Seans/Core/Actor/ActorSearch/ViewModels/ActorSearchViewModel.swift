//
//  FilmViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 14.12.2022.
//

import Foundation
import TMDBSwift

class ActorSearchViewModel: ObservableObject{
    let service = ActorService()
    @Published var actors = [Actor]()

    func searchActors(query: String)
    {
        self.service.searchPeople(query: query) { data in
            self.actors = data
        }
    }
    
}
