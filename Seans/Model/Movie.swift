//
//  Film.swift
//  Seans
//
//  Created by Deniz Ata Eş on 6.12.2022.
//

import SwiftUI

struct Movie: Identifiable, Equatable{
    var id: Int
    var movieTitle: String
    var releaseDate: String
    var movieTime: String
    var movieDescription: String
    var artwork: String
    var vote_average: Double = 0
    var vote_count: Double = 0
    var actors: [Actor]?
//    var similarMovie: [Movie]?
}
