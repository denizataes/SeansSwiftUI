//
//  NewFilmInfoView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 5.03.2023.
//

import SwiftUI
import Kingfisher

struct NewFilmInfoView: View {
    
    @ObservedObject var viewModel: FilmInfoViewModel
    @State private var selectMovie: Bool = false
    init(movieID: Int) {
        self.viewModel = FilmInfoViewModel(movieID: movieID)
    }
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack {
                if viewModel.movie?.posterPath != "" && viewModel.movie?.posterPath != nil {
                    ZStack{
                        backgroundImage
                    }
                    .ignoresSafeArea()
                }
                
                ratingsAndGeneralInfos
                filmInfo
                Spacer()
                if viewModel.movie != nil {
                    VStack {
                        actors
                            .padding(.leading)
                        trailers
                            .padding(.leading)
                        similarMovies
                            .padding(.leading)
                    }
                }
            }
            
        }
        .navigationTitle(viewModel.movie?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    selectMovie.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primary)
                        .shadow(radius: 4)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if((viewModel.movie?.imdbId ) != nil){
                    Link(destination: URL(string: "https://www.imdb.com/title/\(viewModel.movie?.imdbId ?? "")")!) {
                        Image("imdb")
                            .resizable()
                            .frame(width: 26,height: 26)
                            .scaledToFill()
                    }
                }
                
            }
        }
        .sheet(isPresented: $selectMovie) {
            CreateNewPost(selectedMovie: Movie(id: viewModel.movie?.id ?? 0, movieTitle: viewModel.movie?.title ?? "", releaseDate: viewModel.movie?.releaseDate ?? "", movieTime: ("\(viewModel.movie?.runtime ?? 0) Dakika"), movieDescription: viewModel.movie?.overview ?? "", artwork: viewModel.movie?.posterPath ?? "",vote_average: viewModel.movie?.voteAverage ?? 0.0))
            
        }
        
    }
    
}

//struct NewFilmInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//       await NewFilmInfoView(movieID: 1024)
//    }
//}

extension NewFilmInfoView{
    var backgroundImage: some View{
        KFImage(URL(string: "\(Statics.URL)\(viewModel.movie?.posterPath ?? "")" ))
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: 450)
            .ignoresSafeArea()
            .cornerRadius(5)
            .mask(
                LinearGradient(
                    gradient: Gradient(colors: [.black, .clear]),
                    startPoint: .center,
                    endPoint: .bottom
                )
            )
    }
    
    var ratingsAndGeneralInfos: some View{
        HStack{
            Image(systemName: "star.fill")
                .foregroundColor(Color(.systemOrange))
            
            Text(String(format: "%.1f", viewModel.movie?.voteAverage ?? 0.0))
            Text("|")
            Text(String(viewModel.movie?.voteCount ?? 0))
                .font(.caption)
                .foregroundColor(Color(.gray))
            
            Spacer()
            
        }
        .padding(.leading)
        .padding(.trailing)
    }
    
    var filmInfo: some View{
        HStack{
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    if let movie = viewModel.movie {
                        let runtimeInMinutes = (movie.runtime ?? 0) % 60
                        let runtimeInHours = (movie.runtime ?? 0) / 60
                        let runtimeString = "\(runtimeInHours) saat \(runtimeInMinutes) dakika"
                        
                        let genres = movie.genres.map({ $0.name }).joined(separator: ", ")
                        
                        
                        
                        VStack(alignment: .leading, spacing: 8){
                            HStack{
                                Image(systemName: "calendar")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(.systemPurple))
                                Text("\(movie.releaseDate)")
                            }
                            HStack{
                                Image(systemName: "clock")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(.systemPurple))
                                Text("\(runtimeString)")
                            }
                            HStack{
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(.systemPurple))
                                Text("\(genres)")
                            }
                                
                            
                        }
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(Color(.gray))
                    }

                    
                }
                Text(viewModel.movie?.overview ?? "Filme ait bilgi yok...")
                    .padding(.top)
                Button {
                    
                } label: {
                    //                    Text("Read More")
                    //                        .foregroundColor(.purple)
                    //                        .font(.system(size: 16))
                }
                .hAlign(.trailing)
                
                
            }
            .padding(.leading)
            .padding(.top,8)
            Spacer()
        }
    }
    
    var actors: some View{
        
        ActorRowView(id: viewModel.movie?.id ?? 0)
        
    }
    var similarMovies: some View{
        
        SimilarMoviesView(id: viewModel.movie?.id ?? 0)
        
    }
    
    var trailers: some View{
        TrailersView(id: viewModel.movie?.id ?? 0)
    }
}
