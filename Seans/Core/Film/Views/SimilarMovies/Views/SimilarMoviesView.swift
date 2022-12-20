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
        
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {

//                    ForEach(samplePhotos., id: \.self) { index in
                    ForEach(viewModel.similarMovies){movie in

                        NavigationLink{
                            FilmInfoView(movie: movie)
                        }label: {
                            KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: gridLayout.count == 1 ? 200 : 100)
                                .cornerRadius(10)
                                .shadow(color: Color.primary.opacity(0.3), radius: 1)
                            
                        }
                            


                    }
                }
                .padding(.all, 10)
                .animation(.interactiveSpring(), value: gridLayout.count)
            }
            .background(.gray.opacity(0.5))
            .navigationTitle("Benzer filmler")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 4 + 1)
                    } label: {
                        VStack{
                            Image(systemName: "square.grid.2x2")
                                .resizable()
                                .frame(width: 24,height: 24)
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
    }
}

//struct SimilarMoviesView_Previews: PreviewProvider {
//    static var previews: some View {
//        SimilarMoviesView()
//    }
//}
