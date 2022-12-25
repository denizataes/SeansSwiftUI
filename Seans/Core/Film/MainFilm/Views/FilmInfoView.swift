//
//  FilmInfoView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI
import Kingfisher


struct FilmInfoView: View {
    @State private var backgroundColor: Color = .clear
    @State private var pointted: Bool = false
    @Environment(\.presentationMode) var mode
    @StateObject var viewModel = FilmViewModel()
    
    var movie: Movie
    @ObservedObject var viewModel2 = FilmInfoViewModel()
    
    
    var body: some View {

        
            GeometryReader { geometry in
                ScrollView(.vertical,showsIndicators: false){
                    ZStack{
                        filmBackground
                        VStack(alignment: .center){
                            navbar
                            Spacer()
                            
                            filmInfo
                   
                            actors
                            
                            similarMovies
                            
                            reviews
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .background(backgroundColor)
            .onAppear {
                Task{
                    await  viewModel2.fetchMovie(id: movie.id)
                }
                self.setAverageColor()
            }
            .animation(.interpolatingSpring(mass: 3.0,stiffness: 100.0,damping: 120,initialVelocity: 0))
            .navigationBarBackButtonHidden(true)


    }
    
    private func setAverageColor() {
//        let uiColor = UIImage()?.averageColor ?? .clear
        backgroundColor = Color(.clear)
    }
    
}


//struct FilmInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilmInfoView(movie: Movie(id: 5, movieTitle: "Başlık", releaseDate: "22/02/2022", movieTime: "2 saat 2 dakika", movieDescription: "Açıklama", artwork: "Movie2",vote_average: 12,vote_count: 12))
//    }
//}
extension FilmInfoView{
    var navbar: some View{
        VStack{
            HStack(spacing: 15){
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20,height: 18)
                        .bold()
                }

                Spacer()
                
                Button {
                        
                    } label: {
                        VStack{
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 18,height: 18)
                                .bold()
                            Text("Gönderi")
                                .font(.system(size: 10))
                        }
                    }
                
                Button {
                    
                } label: {
                    VStack{
                        Image(systemName: "popcorn")
                            .resizable()
                            .frame(width: 13,height: 18)
                            .bold()
                        Text("Listeme Ekle")
                            .font(.system(size: 10))
                            .multilineTextAlignment(.leading)
                            .bold()
                    }
                }
                
                Button {
                    
                } label: {
                    VStack{
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 13,height: 18)
                            .bold()
                        
                        Text("Paylaş")
                            .font(.system(size: 10))
                            .multilineTextAlignment(.leading)
                            .bold()
                    }
                }
            }
            .foregroundColor(.white)
            .padding()
            .padding(.top,40)
        }
        
    }
    
    var reviews: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Gönderiler")
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                NavigationLink {
                    
                } label: {
                    Text("Hepsini Göster")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .bold()
                }

            }
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(1..<4) { index in
                        ReviewRowView()
                    }
                }
            }
            
        }
        .padding(.top)
    }
    
    var collections: some View{
        
     //   if viewModel.collections.count > 0{
            VStack(alignment: .leading){
                Text("Serinin Diğer Filmleri")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    HStack(spacing: 15){
                        
                        ForEach(viewModel.collections){movie in
                            NavigationLink {
                                FilmInfoView(movie: movie)

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
            .padding()
    }
        
        
    
    var filmBackground: some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
               // .tag(index)
            
            
            let color: Color = .black
            // Custom Gradient
            LinearGradient(colors: [
                .black,
                .black.opacity(0.4),
                //.black.opacity(0.4),
                //color.opacity(0.1),
                //color.opacity(0.1),
                    .black.opacity(0.8),
                    .purple.opacity(0.9)
            ], startPoint: .top, endPoint: .bottom)
            
            // Blurred Overlay
            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.8))
        }
        .ignoresSafeArea()
    }
    
    
    var filmHeader: some View{
        VStack {
            HStack{
                //ZStack(alignment: .bottomTrailing){
                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                        .resizable()
                        .frame(width: 130,height:180)
                        .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text(movie.movieTitle)
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                    
                    HStack(spacing: 0){
                        Image(systemName: "calendar")
                            .bold()
                        
                        Text(movie.releaseDate)
                            .font(.system(size: 12))
                            .bold()
                            .padding(.trailing)
                            .padding(.trailing,5)
                            .padding(.leading, 5)
                    }
                    .foregroundColor(.white)
                    
                    HStack(spacing: 0){
                        if(viewModel2.movie.runtime == 0)
                        {
                            ProgressView()
                        }
                        else if viewModel2.movie.runtime != nil{
                            Image(systemName: "clock")
                                .bold()
                            
                            Text("\(viewModel2.movie.runtime ?? 0) Dakika")
                                .font(.system(size: 12))
                                .bold()
                                .padding(.trailing)
                                .padding(.trailing,5)
                                .padding(.leading, 5)
                        }
                            
                    }
                    .foregroundColor(.white)
                  //  .animation(.easeInOut)
                    
                    
                    

                    
            
                    HStack{
                            
                        VStack{
                            HStack(spacing: 0){
                      

                                Text(String(format: "%.1f", movie.vote_average))
                                    .foregroundColor(.yellow)
                                    .bold()
                                    .font(.system(size: 18))
                                Text("/10")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            VStack{
                                Text(String(format: "%.0f", movie.vote_count))
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.system(size: 14))
                                
                                Text("kişi oyladı")
                                    .font(.system(size: 8))
                                    .foregroundColor(.white)
                                
                            }
                        }.frame(width: 50)
                        
                        Button {
                            pointted.toggle()
                        } label: {
                            HStack{
                                Image(systemName: pointted ? "star.fill" : "star")
                                    .resizable()
                                    .frame(width: 24,height: 24)
                                    .foregroundColor(.yellow)
                                HStack(spacing: 0){
                                    Text(pointted ? "9.8" : "")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .bold()
                                        
                                    Text("/10")
                                        .font(.system(size: 8))
                                        .foregroundColor(.white)
                                        .opacity(pointted ? 1 : 0)
                                }
                            }
                            .frame(width: 80)
                        }
                        
                        if(viewModel2.movie.imdbID != nil && viewModel2.movie.imdbID != ""){
                            Link(destination: URL(string: "https://www.imdb.com/title/\(viewModel2.movie.imdbID ?? "")")!) {
                                Image("imdb")
                                    .resizable()
                                    .frame(width: 24,height: 24)
                                    .scaledToFill()
                                    .shadow(radius: 20)
                            }
                        }
                    }

                }
                .frame(height:180)
                .padding(.leading)
                .padding(.trailing)
                Spacer()
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.top)
        .padding(.leading)
        
        
    }
    
    var filmGeneralInfo: some View{
        VStack {
           
            VStack(alignment: .leading){
                VStack(alignment: .leading,spacing: 15){
                    
                        Text("Film Hakkında")
                            .font(.system(size: 16))
                            .bold()
                        
                    
                }
                .padding(.leading)
                .padding(.top)
                .padding(.bottom,2)
                
                
                Text(movie.movieDescription)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                    .padding(.top,2)
                    .padding(.bottom,30)
                    .padding(.leading)
                    .padding(.trailing)
                    .font(.system(size: 12))
                    
            
                
                
            }
            .foregroundColor(.white)
        }
       // .animation(.interpolatingSpring(mass: 3.0,stiffness: 100.0,damping: 120,initialVelocity: 0))
        
    }
    
//    var actors: some View{
//        VStack(alignment: .center){
//            HStack{
//                VStack{
////                    Text("Kadro")
////                        .font(.callout)
////                        .foregroundColor(.white)
////                        .bold()
//                    ActorView()
//
//                }
//
//
//                Spacer()
//
////                VStack{
////                    Text("Yönetmen")
////                        .font(.callout)
////                        .foregroundColor(.white)
////                        .bold()
////
////                    Image("director")
////                        .resizable()
////                        .aspectRatio(contentMode: .fill)
////                        .frame(width: 90, height: 150)
////                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
////
////                }
//            }
//            .padding(.leading)
//
//        }
//    }
    
    var actors: some View{
        ActorRowView(id: movie.id)
    }
    
    var similarMovies: some View{
        SimilarMoviesView(id: movie.id)
    }
    
    var filmInfo: some View{
        VStack{
         
            filmHeader
            if(viewModel2.movie.genres != nil)
            {
                if viewModel2.movie.genres!.count > 0{
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing: 10){
                            ForEach(viewModel2.movie.genres!) { genre in
                                Button {
                                    
                                } label: {
                                    Text(genre.name ?? "")
                                        .font(.system(size: 10))
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding(8)
                                }
                                .shadow(radius: 10)
                                .background(Capsule().stroke(lineWidth: 2).foregroundColor(.yellow).opacity(0.8))
                                
                            }
                        }
                        .padding(.leading,20)
                        .padding(.trailing)
                        .padding(.top)
                        .padding(.bottom,2)
                    }
                }
            }

            

            TrailersView(id: movie.id)
            
            if(movie.movieDescription != ""){
                filmGeneralInfo
            }
                
        
        }
        .background(.black.opacity(0.65))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height)
    }
}


