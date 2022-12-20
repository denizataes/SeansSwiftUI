//
//  Actor.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.12.2022.
//

import Foundation

struct Actor: Identifiable, Equatable{
    var id: Int
    var character: String?
    var profile_path: String
    var name: String?
    var order: Int?
}

