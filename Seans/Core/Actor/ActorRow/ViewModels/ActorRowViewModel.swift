//
//  FilmViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 14.12.2022.
//

import Foundation
import TMDBSwift

class ActorRowViewModel: ObservableObject{
    let service = ActorService()
    @Published var actors = [Actor]()
    
    func fetchActors(id: Int)
    {
        self.service.fetchActors(with: id) { actors in
            self.actors = actors
            
        }
    }
    
}
