//
//  FilmSelectorView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 19.02.2023.
//

import SwiftUI

struct ActorSelectorView: View {
    @Environment(\.dismiss) private var dismiss
    @State var searchText: String = ""
    @State private var selectedActor: Actor? // Seçilen filmi takip etmek için @State değişkeni
    
    @Namespace var animation
    @ObservedObject var viewModel = ActorSearchViewModel()
    
    // Closure to pass the selected movie to the parent view
    var onActorSelected: ((Actor) -> Void)
    
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
                    TextField("Aktör ara...", text: $viewModel.input, onEditingChanged: {
                        self.viewModel.typing = $0
                    }, onCommit: {
                        self.viewModel.output = self.viewModel.input
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
                                viewModel.input = ""
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
                
                if(viewModel.input == "")
                {
                    ScrollView{
                        LazyVStack(spacing: 0){
                            ForEach(viewModel.popularActors){ actorItem in
                                Button(action: {
                                    selectedActor = actorItem // Seçilen filmi güncelle
                                    onActorSelected(selectedActor!) // Güncellenen filmi kullanarak onFilmSelected'i çağır
                                    dismiss()
                                }) {
                                    ActorSearchRowView(actor: actorItem)
                                }
                            }
                        }
                }
                }
                else{
                    ScrollView{
                        LazyVStack(spacing: 0){
                            ForEach(viewModel.actors){ actorItem in
                                Button(action: {
                                    selectedActor = actorItem // Seçilen filmi güncelle
                                    onActorSelected(selectedActor!) // Güncellenen filmi kullanarak onFilmSelected'i çağır
                                    dismiss()
                                }) {
                                    ActorSearchRowView(actor: actorItem)
                                }
                            }
                            .onChange(of: viewModel.input){ value in
                                viewModel.searchActors(query:viewModel.input)
                            }
                        }
                    }
                }
                
            }
        }
    }
}
