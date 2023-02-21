//
//  Home.swift
//  AnimationChallenge3 (iOS)
//
//  Created by Balaji on 29/03/22.
//

import SwiftUI
import Kingfisher

struct Home: View {
    // MARK: Animated View Properties
    @ObservedObject var viewmodel = FilmViewModel()
    @ObservedObject var viewModelForAllMovie = AllFilmViewModel()

    
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Trend"
    
    // MARK: Detail View Properties
    @State var detailMovie: Movie?
    @State var showDetailView: Bool = false
    // FOR MATCHED GEOMETRY EFFECT STORING CURRENT CARD SIZE
    @State var currentCardSize: CGSize = .zero
    
    // Environment Values
    @Namespace var animation
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ZStack{
            // BG
            BGView()
            
            // MARK: Main View Content
            ScrollView{
                VStack{
                    
                    // Custom Nav Nar
                    NavBar()
                    
                    // Check out the Snap Carousel Video
                    // Link in Description
                    SnapCarousel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: viewmodel.nowPlayingMovies) { movie in
                        
                        GeometryReader{proxy in
                            let size = proxy.size
                            
                            
                            
                            KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                                .resizable()
                                .scaledToFill()
                            //  .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                            
                                .cornerRadius(15)
                                .matchedGeometryEffect(id: movie.id, in: animation)
                                .onTapGesture {
                                    currentCardSize = size
                                    detailMovie = movie
                                    withAnimation(.easeInOut){
                                        showDetailView = true
                                    }
                                }
                            
                        }
                    }
                    .frame(height: 360)
                    // Since Carousel is Moved The current Card a little bit up
                    // Using Padding to Avoid the Undercovering the top element
                    .padding(.top,60)
                    
                    // Custom Indicator
                    CustomIndicator()
                    
//                    HStack{
//                        Text("Popüler")
//                            .font(.title3.bold())
//
//                        Spacer()
//
//                        NavigationLink {
//                            AllFilmView()
//
//                        } label: {
//                            Text("Tüm Filmler")
//                                .font(.system(size: 14, weight: .semibold))
//                                .foregroundColor(.purple.opacity(0.9))
//                        }
//
//
//                    }
//                    .padding(.leading)
//                    .padding(.trailing)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 15){
//                            ForEach(viewmodel.popularMovies){movie in
//                                NavigationLink {
//                                    FilmInfoView(movie: movie)
//                                } label: {
//                                    KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 100, height: 120)
//                                        .cornerRadius(15)
//
//                                }
//                            }
//                        }
//                        .padding()
//                    }
//
                    VStack{
                        ForEach(Category.allCases, id: \.rawValue){ category in
                            FilmSecondRowView(films: viewModelForAllMovie, category: category)
                        }
                    }
                    
                    Spacer()
                    
                    
                    
                    
                }
                .overlay {
                    if let movie = detailMovie,showDetailView{
                        DetailView(movie: movie, showDetailView: $showDetailView, detailMovie: $detailMovie, currentCardSize: $currentCardSize, animation: animation)
                    }
                }
            }
        }
  
    }
    
    // MARK: Custom Indicator
    @ViewBuilder
    func CustomIndicator()->some View{
        HStack(spacing: 5){
            ForEach(viewmodel.nowPlayingMovies.indices,id: \.self){index in
                Circle()
                    .fill(currentIndex == index ? .purple : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
    
    // MARK: Custom Nav Bar
    @ViewBuilder
    func NavBar()->some View{
        HStack(spacing: 0){
            ForEach(["Trend"],id: \.self){tab in
                Button {
                    withAnimation{
                        currentTab = tab
                    }
                } label: {
                 
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background{
                            if currentTab == tab{
                                Capsule()
                                    .fill(.regularMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                }
            }
        }
        .padding()
    }
    
    // MARK: Blurred BG
    @ViewBuilder
    func BGView()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex) {
                
                
                ForEach(viewmodel.nowPlayingMovies.indices,id: \.self){index in
                    
                    KFImage(URL(string: "\(Statics.URL)\(viewmodel.nowPlayingMovies[index].artwork)" ))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            let color: Color = (scheme == .dark ? .black : .white)
            // Custom Gradient
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            
            // Blurred Overlay
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
         
    }
}
