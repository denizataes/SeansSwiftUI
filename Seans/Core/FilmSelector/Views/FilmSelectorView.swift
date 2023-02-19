//
//  FilmSelectorView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 19.02.2023.
//

import SwiftUI

struct FilmSelectorView: View {
    @Environment(\.dismiss) private var dismiss
    @State var searchText: String = ""
    @State private var selectedFilter: SearchFilterViewModel  = .films
    @State private var selectedMovie: Movie? // Seçilen filmi takip etmek için @State değişkeni
    
    @Namespace var animation
    @ObservedObject var viewmodel = ExploreViewModel()
    
    // Closure to pass the selected movie to the parent view
    var onFilmSelected: ((Movie) -> Void)
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("İptal")
                        .foregroundColor(Color(.systemPurple))
                }
                Spacer()
            }
            .padding()
            
            VStack {
                HStack{
                    TextField("Film ara...", text: $viewmodel.input, onEditingChanged: {
                        self.viewmodel.typing = $0
                    }, onCommit: {
                        self.viewmodel.output = self.viewmodel.input
                    })
                    .padding(10)
                    .padding(.horizontal,24)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                                .padding(.leading,8)
                            Spacer()
                            Button {
                                viewmodel.input = ""
                            } label: {
                                Image(systemName: "multiply")
                                    .padding(.trailing,8)
                                    .foregroundColor(.purple)
                                    .bold()
                            }
                            
                        }
                    )
                }
                .padding(.leading)
                .padding(.trailing)
                

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewmodel.searchableFilms) { movie in
                            Button(action: {
                                selectedMovie = movie // Seçilen filmi güncelle
                                onFilmSelected(selectedMovie!) // Güncellenen filmi kullanarak onFilmSelected'i çağır
                                dismiss()
                            }) {
                                FilmSearchRowView(movie: movie)
                            }
                        }
                    }
                }


                
                
                
            }
        }
    }
}
