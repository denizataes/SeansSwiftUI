//
//  FilmView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct FilmView: View {
    var body: some View {
        ZStack{
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    header
                    
                    VStack{
                        HStack{
                            Text("Vizyondakiler 🎬")
                                .font(.system(size: 24))
                                
                            
                            Spacer()
                            
                            NavigationLink {
                                FilmGridView(title:"Vizyondakiler 🎬")
                                
                            } label: {
                                Text("Detaylı Gör 👀")
                                    .bold()
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("mode"))
                            }

                        }
                    }
                    .padding()
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(1..<15) { index in
                                FilmRowView()
                            }
                        }
                    }
                    Divider()
                    
                    VStack{
                        HStack{
                            Text("En İyiler")
                                .font(.system(size: 24))
                                
                            
                            Spacer()
                            
                            NavigationLink {
                                FilmGridView(title:"En İyiler")
                                
                            } label: {
                                Text("Detaylı Gör 👀")
                                    .bold()
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("mode"))
                            }


                        }
                    }
                    .padding()
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{
                            ForEach(1..<15) { index in
                                FilmSecondRowView()
                            }
                        }
                    }.padding()
                    
                    Divider()
                    
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
            
     
    }
}

struct FilmView_Previews: PreviewProvider {
    static var previews: some View {
        FilmView()
    }
}

extension FilmView{
    var header: some View{
        HStack{
            VStack(alignment: .leading,spacing: 5){
                HStack{
                    Text("Merhaba ")
                        .font(.system(size: 22))
                    
                    Text("Deniz Ata")
                        .bold()
                        .font(.system(size: 24))
                        
                }
                Text("Bugün ne izliyorsun ? 🍿")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Image("profile")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 40, height: 40)
        }
        .padding(.top,20)
        .padding(.trailing,30)
        .padding(.leading,20)
    }
}
