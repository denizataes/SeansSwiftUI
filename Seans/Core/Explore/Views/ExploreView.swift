//
//  ExploreView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct ExploreView: View {
    @State var searchText: String = ""
    @State private var selectedFilter: SearchFilterViewModel  = .films
    @Namespace var animation
    @ObservedObject var viewmodel = ExploreViewModel()
    
    var body: some View {
    
            VStack{
                
                VStack {
                    HStack{
                        TextField("Film, dizi veya kullanıcı ara...", text: $viewmodel.input, onEditingChanged: {
                            self.viewmodel.typing = $0
                        }, onCommit: {
                            self.viewmodel.$output = self.viewmodel.$input
                        })
                        .onChange(of: viewmodel.input, perform: { newValue in
                            self.viewmodel.output = self.viewmodel.input
                            if selectedFilter == .users
                            {
                                viewmodel.searchUsers()
                            }
                        })
                        .padding(8)
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
                                    viewmodel.searchableUsers = []
                                    
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
                    
                }
                
                searchFilterBar
                
                if(selectedFilter == .users)
                {
                    ScrollView{
                        ForEach(viewmodel.searchableUsers){ user in
                            NavigationLink {
                                NewProfileView(userUID: user.userUID)
                            } label: {
                                UserRowView(user: user)
                            }
                        }
                    }
                    .refreshable {
                        viewmodel.searchUsers()
                    }
                }
                else if(selectedFilter == .films)
                {
                    ScrollView{
                        LazyVStack(spacing: 0){
                            ForEach(viewmodel.searchableFilms){ movie in
                                NavigationLink {
                                    NewFilmInfoView(movieID: movie.id)
                                    
                                } label: {
                                    FilmSearchRowView(movie: movie)
                                }
                            }
                            
                        }
                    }
                }
                else
                {
                    ActorSearchView(input: $viewmodel.input)
                }
                
            }
            .navigationTitle("Keşfet")
            .navigationBarTitleDisplayMode(.large)
        
    }
}

struct ExploreView_Previews: PreviewProvider {
    @Binding var searchText: String
    
    static var previews: some View {
        ExploreView(searchText: "")
    }
}

extension ExploreView{
    
    var searchFilterBar: some View{
        HStack{
            
            ForEach(SearchFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color("mode") : .gray)
                    
                    if selectedFilter == item{
                        Capsule()
                            .foregroundColor(Color(.systemPurple))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
}
