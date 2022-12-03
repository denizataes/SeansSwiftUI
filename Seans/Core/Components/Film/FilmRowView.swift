//
//  FilmRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 2.12.2022.
//

import SwiftUI

struct FilmRowView: View {
    var body: some View {
        
            VStack(spacing: 5){
                NavigationLink {
                    FilmInfoView()
                } label: {
                    Image("godfather")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 300)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding()
                    
                }

            
                VStack(spacing: 5){
                    HStack{
                        VStack(alignment: .leading, spacing: 5){
                            
                            HStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.yellow)
                                        .frame(width: 60,height: 20)
                                    
                                    HStack{
                                        Text("IMDB")
                                            .foregroundColor(.black)
                                            .font(.system(size: 9))
                                        
                                        Text("9.2")
                                            .foregroundColor(.black)
                                            .font(.system(size: 9))
                                    }
                                    .bold()
       
                                }
                
                                Text("Godfather")
                                    .font(.headline)
                                    
                            }
                            
                            
                            HStack{
                                Image(systemName: "clock")
                                    .foregroundColor(.purple)
                                Text("2 saat 55 dakika")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            
                            HStack{
                                Image(systemName: "calendar")
                                    .foregroundColor(.purple)
                                Text("15 Mart 1972")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                            FriendsWatchRowView()
                        }
                        Spacer()
                        VStack{
                            ZStack{
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 48,height: 48)
                                    .foregroundColor(.yellow)
                                Text("9.8")
                                    .foregroundColor(.black)
                                    .offset(y:2)
                                    .font(.system(size: 12))
                                    .bold()
                            }
                            Text("(10021 Oy)")
                                .foregroundColor(.gray)
                                .font(.system(size: 9))
                                
                        }
                            
                    }
                    .padding()
                    

//
//                    Text("Joaquin Phoenix'in başrolünde olduğu Joker, başarısız bir komedyen olan Arthur Fleck'in, zihninin psikolojik olarak yavaş yavaş tekinsiz sulara yelken açmasıyla bildiğimiz anlamıyla Joker karakterine dönüşümünü konu ediniyor.")
//                        .foregroundColor(.gray)
//                        .font(.system(size: 10))
//                        .multilineTextAlignment(.center)
                }
                .frame(width: 250)
              
            }
         
                
        
    }
}

struct FilmRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmRowView()
    }
}
