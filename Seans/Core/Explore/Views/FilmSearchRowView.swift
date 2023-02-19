//
//  FilmSearchRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 13.12.2022.
//

import SwiftUI
import Kingfisher

struct FilmSearchRowView: View {
    var movie: Movie = Movie(id:1234, movieTitle: "Ad Astra", releaseDate: "1972", movieTime: "2 sa 4 dk", movieDescription: "mesela", artwork: "Movie1",vote_average: 12,vote_count: 12)
    @State private var selectedMovie: Movie? = nil

    var body: some View {
        ZStack{
            
            GeometryReader{proxy in
                let size = proxy.size
            
                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .shadow(radius: 10)
                   // .tag(index)
            
            
                let color: Color = .black
                // Custom Gradient
                LinearGradient(colors: [
       
                    .black.opacity(0.5),
                    //color.opacity(0.1),
                    //color.opacity(0.1),
                        
                        
                ], startPoint: .leading, endPoint: .trailing)
            
                // Blurred Overlay
                Rectangle()
                    .fill(.ultraThinMaterial.opacity(0.9))
            }
            .ignoresSafeArea()
            HStack{
                
                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 70)
                    .cornerRadius(10)
                    .clipShape(Rectangle())
                    .shadow(radius: 10)
                
                
                VStack(alignment: .leading, spacing: 5){
                    Text(movie.movieTitle)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.white)
                    Text("\(movie.releaseDate)")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        
                }
                .padding(.leading)
                
                Spacer()
            }
            .padding(.leading)
            
            
            
        }.frame(height: 90)
        
        
        
    }
}

struct FilmSearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmSearchRowView()
            .previewLayout(.sizeThatFits)
            
            
        
    }
}


//GeometryReader{proxy in
//    let size = proxy.size
//
//    Image("godfather")
//        .resizable()
//        .aspectRatio(contentMode: .fill)
//        .frame(width: size.width, height: size.height)
//        .clipped()
//       // .tag(index)
//
//
//    let color: Color = .black
//    // Custom Gradient
//    LinearGradient(colors: [
//        .black,
//        .black.opacity(0.4),
//        //.black.opacity(0.4),
//        //color.opacity(0.1),
//        //color.opacity(0.1),
//            .black.opacity(0.7),
//            .purple.opacity(0.9)
//    ], startPoint: .top, endPoint: .bottom)
//
//    // Blurred Overlay
//    Rectangle()
//        .fill(.ultraThinMaterial.opacity(0.9))
//}
//.ignoresSafeArea()
