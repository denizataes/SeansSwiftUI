//
//  FilmSecondRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI
import Kingfisher

struct FilmSecondRowView: View {
    var films: AllFilmViewModel
    var category: Category
    var body: some View {
        VStack(alignment: .leading){
            Text(category.title)
                .font(.headline)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15){
                    
                    switch category{
                    case .nowPlaying:
                        
                        ForEach(films.nowPlayingMovies){movie in
                            NavigationLink {
                                FilmInfoView(movie: movie)
                                
                            } label: {
                                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 130)
                                    .cornerRadius(15)
                            }
                        }
                    case .popular:
                        
                        ForEach(films.popularMovies){movie in
                            NavigationLink {
                                FilmInfoView(movie: movie)
                                
                            } label: {
                                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 130)
                                    .cornerRadius(15)
                            }
                        }
                    case .topRated:
                        
                        ForEach(films.topRatedMovies){movie in
                            NavigationLink {
                                FilmInfoView(movie: movie)
                                
                            } label: {
                                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 130)
                                    .cornerRadius(15)
                            }
                        }
                    case .upComing:
                        
                        ForEach(films.upComingMovies){movie in
                            NavigationLink {
                                FilmInfoView(movie: movie)
                                
                            } label: {
                                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 130)
                                    .cornerRadius(15)
                            }
                        }
                        
                    }
                }
            }
            
        }
        .padding()
    }
}


//struct FilmSecondRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilmSecondRowView(title: "Kategoriler")
//            .background(.black)
//    }
//}
