//
//  ProfileView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var mode
    @State var show = false
    var body: some View {
        NavigationView{
            VStack{
                profileSection
                Divider()
                
                VStack(alignment: .leading){
                    HStack{
                        VStack{
                            Text("Gönderiler")
                                .font(.callout)
                                .foregroundColor(.gray)
                            Divider()
                            
                        }
                        
                    }
                    
                    ZStack(alignment: .bottomTrailing) {
                        ScrollView{
                            LazyVStack{
                                ForEach(1..<50) { index in
                                    PostRowView()
                                        .padding(.trailing)
                                        .padding(.leading)
                                        .padding(.vertical,5)
                                        .padding(.top,10)
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                Spacer()
            }
            .padding()
        }
        
//            ToolbarItem(placement: .navigationBarTrailing)
//            {
//
//                NavigationLink{
//                    withAnimation(.easeInOut){
//                        NotificationView()
//                    }
//                } label: {
//                    Image(systemName: "bell")
//                        .foregroundColor(.gray)
//                }
//            }
        
        
    }
        
    
        
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
extension ProfileView{
    var profileSection: some View{
        HStack{
            VStack(alignment: .leading,spacing: 20){
                
                HStack{
                    Text("Gönderiler")
                        .font(.system(size: 12))
                    Text("5")
                        .bold()
                        .font(.system(size: 15))
                }

                HStack{
                    Text("Takipçi")
                        .font(.system(size: 12))
                    Text("102")
                        .bold()
                        .font(.system(size: 15))
                }

                HStack{
                    Text("Takip")
                        .font(.system(size: 12))
                    Text("212")
                        .bold()
                        .font(.system(size: 15))
                }

                
            }
            
            Spacer()
            VStack{
               
            
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 4))
                    .shadow(radius: 10)
                HStack{
                    VStack{
                        profileName
                        Text("@denizataes")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }

                
             
                
              
            }
            Spacer()
            VStack(spacing: 20){
                
                Image(systemName: "popcorn")
                    .resizable()
                    .frame(width: 22,height: 30)
                    .foregroundColor(Color(red: 150/255, green: 28/255, blue: 48/255))
                
                
                HStack{
                    Text("Film")
                        .font(.system(size: 12))
                    Text("212")
                        .bold()
                        .font(.system(size: 15))
                }
                    
                HStack{
                    Text("Dizi")
                        .font(.system(size: 12))
                    Text("212")
                        .bold()
                        .font(.system(size: 15))
                }


                
            }
            .padding()
        
        }
    }
    
    var profileName: some View{
        ZStack{
            
                Text("Deniz Ata EŞ")
                    .foregroundColor(Color("mode"))
                    .font(.system(size: 20))
                
                Text("Deniz Ata EŞ")
                    .foregroundColor(.purple)
                    .font(.system(size: 20))
                    .mask{
                        Capsule()
                            .fill(LinearGradient(gradient: .init(colors: [.red,.gray,.black]), startPoint: .top, endPoint: .bottom))
                            .rotationEffect(.init(degrees: 30))
                            .offset(x:self.show ? 100 : -130)
                    }
            
        }
        .onAppear{
            withAnimation(Animation.default.speed(0.08).delay(0)
                .repeatForever(autoreverses: false)){
                self.show.toggle()
            }
        }
    }
}


