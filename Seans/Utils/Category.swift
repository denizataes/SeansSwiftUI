//
//  SideMenuViewModel.swift
//  TwitterSwiftUI
//
//  Created by Deniz Ata Eş on 18.11.2022.
//

import Foundation

enum Category: Int, CaseIterable{

    case nowPlaying
    case popular
    case topRated
    case upComing
    
    
    var title: String{
        switch self{
        case .nowPlaying: return "Vizyondakiler 🍿"
        case .upComing: return "Yakında Çıkacaklar ⌛️"
        case .popular: return "En Popüler ⚡️"
        case .topRated: return "En İyiler 💯"
        }
    }
}
