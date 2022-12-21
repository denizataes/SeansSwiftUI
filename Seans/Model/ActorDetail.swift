//
//  ActorDetail.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import Foundation
struct ActorDetail: Identifiable, Equatable{
    
    var id: Int?
    var adult: Bool?
    var also_known_as: [String]?
    var biography: String?
    var birthday: String?
    var deathday: String?
    var homepage: String?
    var imdb_id: String?
    var name: String?
    var place_of_birth: String?
    var popularity: Double?
    var profile_path: String?
    var age: Int?
    var deathAge: Int?
    
}
