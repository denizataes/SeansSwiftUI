//
//  ActorService.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
import TMDBSwift


struct ActorService{
    
    func fetchActorDetail(id: Int,completion: @escaping(ActorDetail) -> Void){
        var actor = ActorDetail()
        PersonMDB.person_id(personID: id) { clientReturn, data in
            if let data = data{
                
                
                let group = DispatchGroup()
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    actor = ActorDetail(id: data.id,
                                             adult: data.adult,
                                             also_known_as: data.also_known_as,
                                             biography: data.biography,
                                             birthday: data.birthday,
                                             deathday: data.deathday,
                                             homepage: data.homepage,
                                             imdb_id: data.imdb_id,
                                             name: data.name,
                                             place_of_birth: data.place_of_birth,
                                             popularity: data.popularity,
                                             profile_path: data.profile_path
                    )
                    
                    group.leave()
                }
                
                group.notify(queue: .main, execute: {
                    completion(actor)
                })
            }
        }
        
    }
    
    
    func fetchActors(with id: Int, completion: @escaping ([Actor]) -> Void){
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
    
}
