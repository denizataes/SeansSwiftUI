//
//  FilmSecondRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct FilmSecondRowView: View {
    var title: String
    //    var movie: [Movie]
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15){
                    ForEach((1...10), id: \.self){movie in
                        NavigationLink {
                            FilmInfoView()
                            
                        } label: {
                            Image("joker")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 130)
                                .cornerRadius(15)
                        }

                        
                    
                    }
                }
          
            }
        }
        .padding()
    }
}

struct FilmSecondRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmSecondRowView(title: "Kategoriler")
            .background(.black)
    }
}
