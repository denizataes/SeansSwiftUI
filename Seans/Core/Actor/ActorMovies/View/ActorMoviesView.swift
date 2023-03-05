//
//  ActorMoviesView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import SwiftUI
import Kingfisher

struct ActorMoviesView: View {
    @ObservedObject var viewModel: ActorMoviesViewModel
    @Environment(\.presentationMode) var mode
    
    init(id: Int){
        self.viewModel = ActorMoviesViewModel(id: id)
    }
    
    var body: some View {
        
        if viewModel.actorMovies.count > 0{
            VStack(alignment: .leading){
                Text("Oynadığı Filmler")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    HStack(spacing: 15){
                        
                        ForEach(viewModel.actorMovies){movie in
                            NavigationLink {
                                NewFilmInfoView(movieID: movie.id)

                            } label: {
                                
                                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 120)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
            }
            .animation(.easeInOut)
            .padding()
        }
    }
}

//struct ActorMoviesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActorMoviesView()
//    }
//}
