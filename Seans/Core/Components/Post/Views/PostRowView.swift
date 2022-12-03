//
//  PostRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 27.11.2022.
//

import SwiftUI

struct PostRowView: View {
    @State private var isLiked = false
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                leftSide
                profilSection
            }
            buttons
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        Divider()
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView()
            //.previewLayout(.sizeThatFits)
        
    }
}

extension PostRowView{
    
    var leftSide: some View{
        
        HStack(alignment: .top) {
            VStack{
                NavigationLink {
                    ActorView()
                    
                } label: {
                    Image("actor1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32,height: 32)
                        .clipShape(Circle())
                }
                Text("Joaquin Phoenix")
                    .font(.system(size: 5))
                    .foregroundColor(.gray)
                    .italic()
                NavigationLink {
                    ActorView()
                    
                } label: {
                    Image("actor2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32,height: 32)
                        .clipShape(Circle())
                }
                Text("Robert De Niro")
                    .font(.system(size: 5))
                    .foregroundColor(.gray)
                    .italic()
                NavigationLink {
                    ActorView()
                    
                } label: {
                    Image("actor3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32,height: 32)
                        .clipShape(Circle())
                }
                Text("Zazie Beetz")
                    .font(.system(size: 5))
                    .foregroundColor(.gray)
                    .italic()
                Spacer()
                ZStack{
                    Color(red: 245/255, green: 222/255, blue: 80/255)
                        .frame(width: 32,height:32 )
                        .clipShape(Circle())
                    VStack{
                        Text("IMDb")
                            .font(.system(size: 6))
                            .bold()
                            .foregroundColor(.black)
                        Text("8.3")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                    }
                }
                
//                ScrollView(.vertical,showsIndicators: false){
//                    VStack{
//                        ZStack{
//                            Color(red: 245/255, green: 222/255, blue: 80/255)
//                                .frame(width: 32,height:32 )
//                                .clipShape(Circle())
//                            VStack{
//                                Text("IMDb")
//                                    .font(.system(size: 6))
//                                    .bold()
//                                Text("8.3")
//                                    .foregroundColor(.black)
//                                    .font(.system(size: 12))
//                            }
//                        }
//                        Divider()
//                        ZStack{
//                            Color(red: 169/255, green: 66/255, blue: 66/255)
//                                .frame(width: 32,height:32)
//                                .clipShape(Circle())
//                            VStack{
//                                Text("RT")
//                                    .font(.system(size: 6))
//                                    .bold()
//                                Text("68%")
//                                    .font(.system(size: 12))
//                            }
//                            .foregroundColor(.white)
//                        }
//
//                        Divider()
//
//                    }
//                }
//                .frame(maxWidth: 1,maxHeight: 48)
                
                
                
                
                
                
                
            }
            
            VStack(alignment: .leading){
                NavigationLink {
                    FilmInfoView()
                    
                } label: {
                    Image("joker")
                        .resizable()
                        .frame(width:100 ,height: 140)
                        .cornerRadius(10)
                        
                }
                
                VStack(alignment: .leading,spacing: 4){
                    Text("Joker")
                        .font(.headline)
                    Text("4 Ekim 2019")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("2 Saat 2 dakika")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
//                    ScrollView(.vertical,showsIndicators: false){
//                        VStack(alignment: .leading){
//                            //ForEach(0..<8) { index in
//                            Text("4 Ekim 2019")
//                                .font(.footnote)
//                                .foregroundColor(Color(.systemGray2))
//                            Divider()
//
//                            Text("2 Saat 2 Dakika")
//                                .font(.footnote)
//                                .foregroundColor(Color(.systemGray2))
//
//                            //}
//                        }
//                    }
//                    .frame(maxWidth: 115,minHeight: 16)
                }

                
                
            }
        }
    }
    
    var profilSection: some View{
        
        VStack(alignment: .leading){
            HStack{
                
                NavigationLink {
                    ProfileView()
                        
                } label: {
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32,height: 32)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("Deniz Ata EŞ")
                            .font(.system(size: 12))
                            .bold()
                            .foregroundColor(Color("mode"))
                        
                        Text("@denizataes")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                

                Spacer()
                Text("2sa")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            Text("Gerçekten son yıllarda izlediğim en iyisiydi. Joaquin sen bir efsanesin ! 👏🏻")
                .font(.footnote)
            Spacer()
        }
        .frame(maxWidth: .infinity,  maxHeight: .infinity)
    }
    
    var buttons: some View{
        HStack(spacing: 10){
     
            
            Button {
                
            } label: {
                HStack{
                    Image(systemName: "message")
                        .font(.subheadline)
                        .foregroundColor(.green)
                    Text("3")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button {
                isLiked.toggle()
                
            } label: {
                HStack{
                    Image(systemName: isLiked  ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .font(.subheadline)
                    Text("61")
                        .font(.caption2)
                        .foregroundColor(.gray)

                }
                    
                
            }
            Spacer()
            
            Button {
                
            } label: {
                HStack{
                    Image(systemName: "popcorn")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                    Text("1")
                        .font(.caption2)
                        .foregroundColor(.gray)

                }
            }
            

        }
        .foregroundColor(.gray)
        .padding(.leading)
        .padding(.trailing)
    }
}
