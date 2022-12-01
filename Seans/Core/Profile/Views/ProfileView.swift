//
//  ProfileView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    @State private var selectedFilter: TweetFilterViewModel  = .feeds
    @State var show = false
    var socialMedia = ["instagram","twitter","tiktok","youtube", "snapchat"]
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                profileSection
                
                userInfoDetails
                
                tweetFilterBar
                
                ZStack(alignment: .bottomTrailing) {
                                        
                                        LazyVStack{
                                            ForEach(1..<50) { index in
                                                PostRowView()
                                                    .padding(.trailing)
                                                    .padding(.leading)
                                                    .padding(.vertical,5)
                                                    .padding(.top,10)
                                            }
                                            
                                        }
                                        
                                        
                }.padding(.top)
            
                Spacer()
            }
            .padding()
        }
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
                HStack {
                    Spacer()
                    VStack{
                        GeometryReader { geometry in
                            Image("profile")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 4))
                                .shadow(radius: 10)
                            .foregroundColor(.init(hue: 0, saturation: 0.0, brightness: 0.9))
                                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                            .overlay(
                                CircularLayout(radius: (geometry.size.width * 0.8) / 2, name: socialMedia)
                                    .offset(x: geometry.size.width * 0.1, y: geometry.size.width * 0.1)
                            )
                        }
                        
                    }
                    .frame(height: 180)
                    Spacer()
                }
               
                
            VStack(alignment: .leading,spacing: 8){
                HStack{
                    //profileName ANİMASYONLU
                    Text("Deniz Ata EŞ")
                        .foregroundColor(Color("mode"))
                        .font(.system(size: 20))

                }
                Text("@denizataes")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                
                Text("Sinema, tiyatro en büyük sevdam... 🎬")
                    .foregroundColor(.gray)
                    .font(.caption2)
                
                    Button {
                        
                    } label: {
                            HStack{
                                Text("Takip Et")
                                    .font(.system(size: 12))
                                    .bold()
                                    .foregroundColor(.purple)
                                
                                
                                Image(systemName: "person.badge.plus")
                                    .resizable()
                                    .frame(width: 16,height: 16)
                                    .foregroundColor(.purple)
                                    .bold()
                            }
                            .frame(width: 90, height: 30)
                            .foregroundColor(.white)
                            .background(LinearGradient(colors: [.gray,.clear,.clear,.clear,.gray], startPoint: .bottomLeading, endPoint: .topTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
            }
            
            
                
            Spacer()
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
    
    var userInfoDetails: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 40)
            {
                
                VStack{
                    Text("Gönderiler")
                        .font(.system(size: 14))
                    Text("10")
                        .font(.system(size: 16))
                        .bold()
                }
                
                VStack{
                    Text("Takipçi")
                        .font(.system(size: 14))
                    Text("165")
                        .font(.system(size: 16))
                        .bold()
                }
                
                VStack{
                    Text("Takip")
                        .font(.system(size: 14))
                    Text("203")
                        .font(.system(size: 16))
                        .bold()
                }
                
                
                VStack{
                    Text("Film")
                        .font(.system(size: 14))
                    Text("212")
                        .font(.system(size: 16))
                        .bold()
                }
                
                VStack{
                    Text("Dizi")
                        .font(.system(size: 14))
                    Text("17")
                        .font(.system(size: 16))
                        .bold()
                }
                
                
                VStack{
                    HStack{
                        Text("Katılma Tarihi")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                        
                        Image(systemName: "calendar.circle")
                            .foregroundColor(.purple)
                    }
                    Text("17 Temmuz 2022")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                }
                
                Spacer()
                
            }
            Divider()
        }
    }
    
    
    var tweetFilterBar: some View{
        HStack{
            
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color("mode") : .gray)
                    
                    if selectedFilter == item{
                        Capsule()
                            .foregroundColor(Color(.systemPurple))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
}


