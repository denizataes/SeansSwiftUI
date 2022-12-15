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
    var movie: Movie
    
    
    var body: some View {

        GeometryReader { geometry in
            ScrollView(.vertical,showsIndicators: false){
                ZStack{
                    filmBackground
                    VStack(alignment: .center){
                        navbar
                        Spacer()
                        VStack{
                            filmHeader
                            filmGeneralInfo
                        }
                        .background(.black.opacity(0.65))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        actors
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
            self.setAverageColor()
        }
        .navigationBarBackButtonHidden(true)

    }
    
    private func setAverageColor() {
//        let uiColor = UIImage()?.averageColor ?? .clear
        backgroundColor = Color(.clear)
    }
    
}


struct FilmInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FilmInfoView(movie: Movie(id: 5, movieTitle: "Başlık", releaseDate: "22/02/2022", movieTime: "2 saat 2 dakika", movieDescription: "Açıklama", artwork: "Movie2",vote_average: 12,vote_count: 12))
    }
}
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
    
    var filmBackground: some View{
//        VStack(spacing: 0){
//            Image("godfather")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .opacity(0.2)
//            Image("godfather")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .opacity(0.2)
//        }
        
        
        
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
                    .black.opacity(0.7),
                    .purple.opacity(0.9)
            ], startPoint: .top, endPoint: .bottom)
            
            // Blurred Overlay
            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.9))
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
            
    //                    .cornerRadius(15)
    //
    //               Image("youtube")
    //                    .resizable()
    //                    .frame(width: 32,height: 32)
    //                    .clipShape(Circle())
    //                    .opacity(0.5)
    //                    .foregroundColor(.red)
    //                    .padding(.trailing,5)
    //                    .padding(.bottom,5)
                        
                        
            //    }
                 
                
                
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text(movie.movieTitle)
                            .font(.system(size: 18))
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    HStack{
                        Image(systemName: "calendar")
                        
                        Text(movie.releaseDate)
                            .font(.system(size: 10))
                            .bold()
                            .padding(.trailing)
                            .padding(.trailing,5)
                            .padding(.leading, 5)
                    }
                    .foregroundColor(.white)
                    
                    
                    NavigationLink {
                        
                    } label: {
                        HStack{
                            Image(systemName: "play.circle")
                                .resizable()
                                .frame(width: 16,height: 16)
                                .foregroundColor(.white)
                                
                            
                            Text("Fragman İzle")
                                .font(.system(size: 10))
                                .bold()
                                .foregroundColor(.white)
                       
                        }
                        .frame(width:100 , height: 30)
                        .foregroundColor(.white)
                        .background(.red).opacity(0.9)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    
                    HStack{
                        ZStack{
                            Color(red: 245/255, green: 222/255, blue: 80/255)
                                .frame(width: 32,height:32 )
                                .clipShape(Circle())
                            
                            VStack{
                                Text("IMDb")
                                    .font(.system(size: 6))
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                        VStack{
                            HStack(spacing: 0){
                                Text(String(movie.vote_average))
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.system(size: 14))
                                Text("/10")
                                    .font(.system(size: 8))
                                    .foregroundColor(.white)
                            }
                            Text(String(movie.vote_count))
                                .foregroundColor(.gray)
                                .font(.system(size: 8))
                        }
                        
                        Button {
                            pointted.toggle()
                        } label: {
                            HStack{
                                Image(systemName: pointted ? "star.fill" : "star")
                                    .resizable()
                                    .frame(width: 32,height: 32)
                                    .foregroundColor(.green)
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
                    }

                }
                .frame(height:180)
                .padding(.leading)
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
                    HStack{
                        Text("Film Hakkında")
                            .font(.system(size: 16))
                            .bold()
                        Text(movie.movieTime)
                            .font(.system(size: 8))
                        Spacer()
                    }
                }
                .padding(.leading)
                .padding(.top)
                .padding(.bottom,2)
                
//                Text("Sicilya'dan göç eden Corleone ailesi, Amerika'da yerleşme çabalarını sürdürürken kendilerine kaba kuvvet kullanmaya kalkan ve yapmaya kalktıkları her işten haraç isteyen bir takım kimliği belirsiz kişilere karşı onlar da kaba kuvvet kullanmaya ve bunda da başarılı olmaya başlayınca kendilerini tahmin bile edemeyecekleri bir yaşantının içinde bulurlar. Bir taraftan son derece katı örf ve aile yaşantısı diğer tarafta ise acımasızca önlerine çıkanları yok etmeye başlayan Corleone ailesi bir müddet sonra Amerika'nın en korkulan mafya topluluğu haline gelmiştir. Kendileri her ne kadar mafya değil bir aile olduklarını söyleseler de.")
                Text(movie.movieDescription)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                    .padding(.top,2)
                    .padding(.bottom,10)
                    .padding(.leading)
                    .padding(.trailing)
                    .font(.system(size: 12))
                    
            
                
                
            }
            .foregroundColor(.white)
        }
        
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
        VStack(alignment: .leading){
            HStack{
                Text("Oyuncular")
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
                    ForEach(1..<5) { index in
                        ActorRowView()
                    }
                }
            }
        }
    }
}


