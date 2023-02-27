//
//  FilmViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 14.12.2022.
//

import Foundation
import TMDBSwift

class ActorSearchViewModel: ObservableObject{
    @Published var output: String = ""
    @Published var input: String = ""
    @Published var typing = false
    
    let service = ActorService()
    @Published var actors = [Actor]()
    @Published var popularActors = [Actor]()
    
    init() {
     fetchPopularActors()
    }

    func searchActors(query: String)
    {
        self.service.searchPeople(query: query) { data in
            self.actors = data
        }
    }
    
    func fetchPopularActors(){
        self.service.fetchPopularActors { actors in
            self.popularActors = actors
        }
        
    }
    
}
