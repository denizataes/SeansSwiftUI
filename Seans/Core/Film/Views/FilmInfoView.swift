//
//  FilmInfoView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct FilmInfoView: View {
    var body: some View {
        ZStack{
            Image("godfather")
                .resizable()
                .scaledToFill()
                .opacity(0.2)
        
                
        }
        .ignoresSafeArea()
    }
}

struct FilmInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FilmInfoView()
    }
}
