//
//  DetailView.swift
//  AnimationChallenge3 (iOS)
//
//  Created by Balaji on 29/03/22.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    var movie: Movie
    @Binding var showDetailView: Bool
    @Binding var detailMovie: Movie?
    @Binding var currentCardSize: CGSize
    
    var animation: Namespace.ID
    
    @State var showDetailContent: Bool = false
    @State var offset: CGFloat = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                Button {
                    
                withAnimation(.easeInOut){
                    showDetailContent = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeInOut){
                        showDetailView = false
                    }
                }
                    
                } label: {
                    HStack{
                        Spacer()
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 16,height: 16)
                            .foregroundColor(.white)
                    }
                    .padding()
                }

             
                    
                
                KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: currentCardSize.width, height: currentCardSize.height)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: movie.id, in: animation)
                
                VStack(alignment: .leading,spacing: 15){
                    Text(movie.movieTitle)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,25)
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                        Text(movie.releaseDate)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    HStack{
                        Image(systemName: "clock")
                            .foregroundColor(.white)
                        Text(movie.movieTime)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    Text(movie.movieDescription)
                        .multilineTextAlignment(.leading)
                    
//                    Button {
//
//
//                    } label: {
//
//                        Text("Book Ticket")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .padding(.vertical)
//                            .frame(maxWidth: .infinity)
//                            .background{
//                                RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                    .fill(.blue)
//                            }
//                    }
//                    .padding(.top,20)
                }
                .opacity(showDetailContent ? 1 : 0)
                .offset(y: showDetailContent ? 0 : 200)
            }
            .padding()
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut){
                showDetailContent = true
            }
        }
        .onChange(of: offset) { newValue in
            // YOUR OWN CUSTOM THERSOLD
            if newValue > 30{
                withAnimation(.easeInOut){
                    showDetailContent = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeInOut){
                        showDetailView = false
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
