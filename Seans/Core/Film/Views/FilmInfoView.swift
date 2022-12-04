//
//  FilmInfoView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct FilmInfoView: View {
    @State private var backgroundColor: Color = .clear
    @State private var pointted: Bool = false
    @Environment(\.presentationMode) var mode
    
    
    var body: some View {
        
   
        GeometryReader { geometry in
            ScrollView(.vertical,showsIndicators: false){
                ZStack{
                    filmBackground
                    VStack(alignment: .center){
                        navbar
                        Spacer()
                        filmHeader
                        actors
                        reviews
                        filmGeneralInfo
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
        let uiColor = UIImage(named: "godfather")?.averageColor ?? .clear
        backgroundColor = Color(uiColor)
    }
    
}


struct FilmInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FilmInfoView()
    }
}
extension FilmInfoView{
    var navbar: some View{
        VStack{
            HStack(spacing: 10){
                Button {
                   
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 24,height: 20)
                        .bold()
                        .foregroundColor(.white)
                }

                Spacer()
                
                Button {
                        
                    } label: {
                        VStack{
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20,height: 20)
                                .bold()
                                .foregroundColor(.white)
                            Text("Gönderi")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                        }
                    }
                
                Button {
                    
                } label: {
                    VStack{
                        Image(systemName: "popcorn")
                            .resizable()
                            .frame(width: 13,height: 20)
                            .bold()
                            .foregroundColor(.white)
                        Text("Listeme Ekle")
                            .font(.system(size: 10))
                            .multilineTextAlignment(.leading)
                            .bold()
                            .foregroundColor(.gray)
                    }
                }
                
                Button {
                    
                } label: {
                    VStack{
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 13,height: 20)
                            .bold()
                            .foregroundColor(.white)
                        Text("Paylaş")
                            .font(.system(size: 10))
                            .multilineTextAlignment(.leading)
                            .bold()
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .padding(.top,20)
        }
        
    }
    
    var reviews: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Gönderiler")
                    .font(.largeTitle)
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
    }
    
    var filmBackground: some View{
        VStack(spacing: 0){
            Image("godfather")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.2)
            Image("godfather")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.2)
        }
    }
    
    var filmHeader: some View{
        HStack{
            //ZStack(alignment: .bottomTrailing){
                Image("godfather")
                    .resizable()
                    .frame(width: 130,height:180)
                    .shadow(radius: 50)
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
             
            
            
            VStack(alignment: .leading){
                HStack{
                    Text("The Godfather")
                        .font(.system(size: 28))
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                
                HStack{
                    ZStack{
                        Color(red: 245/255, green: 222/255, blue: 80/255)
                            .frame(width: 32,height:32 )
                            .clipShape(Circle())
                        
                        VStack{
                            Text("IMDb")
                                .font(.system(size: 9))
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                    VStack{
                        HStack(spacing: 0){
                            Text("8.8")
                                .foregroundColor(.white)
                                .bold()
                                .font(.system(size: 16))
                            Text("/10")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        Text("2.339.685")
                            .foregroundColor(.gray)
                            .font(.system(size: 9))
                    }
                }
                
              
                    Button {
                        pointted.toggle()
                    } label: {
                        HStack{
                            Image(systemName: pointted ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 32,height: 32)
                                .foregroundColor(pointted ? .purple : .white)
                            HStack(spacing: 0){
                                Text(pointted ? "9.8" : "Puan Ver")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .bold()
                                Text("/10")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                    .opacity(pointted ? 1 : 0)
                            }
                        }
                    }
                
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


                
                
                
                
            }
            .frame(height:180)
            .padding(.leading)
            Spacer()
            
        }
        .background(backgroundColor.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        
    }
    
    var filmGeneralInfo: some View{
        VStack {
            HStack{
                Text("Daha Fazla...")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
            }
            VStack(alignment: .leading){
                //                Text("Filmin Konusu")
                //                    .font(.system(size: 18))
                //                    .padding(.leading)
                //                    .padding(.top)
                //                    .bold()
                VStack(alignment: .leading,spacing: 15){
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundColor(.black)
                        Text("19 Ekim 1973")
                            .font(.system(size: 10))
                            .bold()
                            .foregroundColor(.black)
                        Spacer()
                        HStack{
                            FilmCategoryButton(buttonName: "Aksiyon")
                            FilmCategoryButton(buttonName: "Suç")
                            FilmCategoryButton(buttonName: "Drama")
                        }
                        .padding(.trailing)
                    }
                
                }
                .padding(.leading)
                .padding(.top)
                
                Text("Konu")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.leading)
                
                Divider()
                
                Text("Sicilya'dan göç eden Corleone ailesi, Amerika'da yerleşme çabalarını sürdürürken kendilerine kaba kuvvet kullanmaya kalkan ve yapmaya kalktıkları her işten haraç isteyen bir takım kimliği belirsiz kişilere karşı onlar da kaba kuvvet kullanmaya ve bunda da başarılı olmaya başlayınca kendilerini tahmin bile edemeyecekleri bir yaşantının içinde bulurlar. Bir taraftan son derece katı örf ve aile yaşantısı diğer tarafta ise acımasızca önlerine çıkanları yok etmeye başlayan Corleone ailesi bir müddet sonra Amerika'nın en korkulan mafya topluluğu haline gelmiştir. Kendileri her ne kadar mafya değil bir aile olduklarını söyleseler de.")
                    .multilineTextAlignment(.leading)
                    .padding(.top,10)
                    .padding(.bottom,10)
                    .padding(.leading)
                    .padding(.trailing)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .bold()
            
                
                
            }
            .background(.orange.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        
    }
    
    var actors: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Oyuncular")
                    .font(.largeTitle)
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


