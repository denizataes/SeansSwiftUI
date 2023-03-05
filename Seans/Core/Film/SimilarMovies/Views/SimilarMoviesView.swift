//
//  SimilarMoviesView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 18.12.2022.
//

import SwiftUI
import Kingfisher

struct SimilarMoviesView: View {
    @State var gridLayout: [GridItem] = [ GridItem() ]
    @ObservedObject var viewModel: SimilarMoviesViewModel
    @Environment(\.presentationMode) var mode
    
    init(id: Int){
        self.viewModel = SimilarMoviesViewModel(id: id)
    }
    
    var body: some View {
        if viewModel.similarMovies.count > 0{
            VStack(alignment: .leading){
                Text("Benzer Filmler")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .bold()
                    .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    HStack(spacing: 15){
                        
                        ForEach(viewModel.similarMovies){movie in
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
            .animation(.easeOut(duration: 1))
        }
            
        
    }
    
 
}
