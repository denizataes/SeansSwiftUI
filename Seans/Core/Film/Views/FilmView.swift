//
//  FilmView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct FilmView: View {
    var body: some View {
            VStack{
                Home()
                    .padding(.top,40)
            }
            .edgesIgnoringSafeArea(.all)
        
            
    }
}

struct FilmView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
