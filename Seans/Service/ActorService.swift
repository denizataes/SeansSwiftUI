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
                    let dateFormatter = DateFormatter()
                    if let birthday = actor.birthday {
                        actor.age = calcAge(birthday: birthday)
                    }
                    
                    if actor.deathday != nil, actor.birthday != nil{
                        actor.deathAge = calcDeathAge(birthday: actor.birthday!, deathDay: actor.deathday!)
                    }
                    
                    group.leave()
                }
                
                group.notify(queue: .main, execute: {
                    completion(actor)
                })
            }
        }
        
    }
    
    
    func calcDeathAge(birthday: String, deathDay: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let deathDate = dateFormater.date(from: deathDay)
        let calcAge = calendar.components(.year, from: birthdayDate!, to: deathDate!, options: [])
        let deathAge = calcAge.year
        return deathAge!
    }
    
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
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
    
    
//    func searchMovies(query: String, completion: @escaping([Movie]) -> Void){
//        var movieList = [Movie]()
//        SearchMDB.movie(query: query, language: "tr" , page: 1, includeAdult: true, year: nil, primaryReleaseYear: nil) { clientReturn, movie in
//            if let movie = movie{
//                movie.forEach { MovieMDB in
//                    guard let poster = MovieMDB.poster_path  else {return} // poster yoksa listeye alma
//                    let date = MovieMDB.release_date != "" && MovieMDB.release_date != nil ? convertDate(dateString: MovieMDB.release_date) : ""
//                    var mov = Movie(id: MovieMDB.id, movieTitle: MovieMDB.title ?? "", releaseDate: date , movieTime: "2 saat", movieDescription: MovieMDB.overview ?? "", artwork: poster)
//                    movieList.append(mov)
//                        completion(movieList)
//
//
//                }
//            }
//
//
//        }
//    }
    
    func searchPeople(query: String, completion: @escaping([Actor]) -> Void){
        var actorList = [Actor]()
        
        SearchMDB.person(query: query, page: 1, includeAdult: true) { clientReturn, person in
            if let data = person{
                data.forEach { pers in
                    guard pers.profile_path != nil else {return}
                    let personItem = Actor(id: pers.id, profile_path: pers.profile_path ?? "" ,name: pers.name ?? "")
                    actorList.append(personItem)
                }
            }
            completion(actorList)
        }
    }
    
    
}
