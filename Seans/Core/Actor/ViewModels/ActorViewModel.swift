//
//  ActorViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
class ActorViewModel: ObservableObject{
    var id: Int
    let service = ActorService()
    @Published var actor = ActorDetail()

    init(id: Int)
    {
        self.id = id
        fetchActor()
    }
    func fetchActor()
    {
        service.fetchActorDetail(id: id) { ActorDetail
            in
            self.actor = ActorDetail
            
        }
    }
    
}
