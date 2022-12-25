//
//  TrailersViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 25.12.2022.
//

import Foundation
import TMDBSwift


class FilmCategoryViewModel: ObservableObject{
    let service = FilmService()
    @Published var categories = [Videos]()
    var id: Int

    init(id: Int)
    {
        self.id = id
        fetchFilmCategory()
    }
    
    func fetchFilmCategory(){

    }
    
}




