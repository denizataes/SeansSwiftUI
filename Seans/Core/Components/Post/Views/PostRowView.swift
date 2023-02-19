//
//  PostRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 27.11.2022.
//

import SwiftUI
import Kingfisher

struct PostRowView: View {
    var post: Post
    @State private var isLiked = false
    let currentDate = Date()
    let formatter = DateFormatter()
    
    init(post: Post) {
        self.post = post
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.timeZone = TimeZone.current
    }
    

    
    var body: some View {
     //   ZStack{
           // background
        
        GeometryReader{proxy in
            let size = proxy.size



            KFImage(URL(string: "\(post.moviePhoto)" ))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
                .shadow(radius: 10)
                .cornerRadius(10)
               // .tag(index)

            // Custom Gradient
            LinearGradient(colors: [

                .black.opacity(0.8)
            ], startPoint: .leading, endPoint: .trailing)

            // Blurred Overlay
            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.8))
                .cornerRadius(10)


            VStack(alignment: .leading){
                HStack{
                    leftSide
                    profilSection
                }
                buttons
            }
            .padding()


            Divider()
        }
        .frame(height: 250)
        
        

       
        
        
        

        
    }
}

//struct PostRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostRowView()
//            //.previewLayout(.sizeThatFits)
//
//    }
//}

extension PostRowView{
    
    var background: some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            KFImage(URL(string: "\(post.moviePhoto)" ))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
               // .tag(index)
            
            
            let color: Color = .black
            // Custom Gradient
            LinearGradient(colors: [
                .black.opacity(0.1)
      
            ], startPoint: .top, endPoint: .bottom)
            
            // Blurred Overlay
            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.99))
        }
        .ignoresSafeArea()
    }
    
    var leftSide: some View{
        
        HStack(alignment: .top) {
            VStack(alignment: .leading){
                NavigationLink {
                   // FilmInfoView()
                    
                } label: {
                    KFImage(URL(string: "\(post.moviePhoto)" ))
                        .resizable()
                        .frame(width:100 ,height: 140)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        
                }
                
                VStack(alignment: .leading,spacing: 4){
                    Text(post.movieName)
                        .font(.headline)
//                    Text("4 Ekim 2019")
//                        .font(.system(size: 12))
//                        .foregroundColor(.gray)
//                    Text("2 Saat 2 dakika")
//                        .font(.system(size: 10))
//                        .foregroundColor(.gray)
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
                    KFImage(post.userProfileURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32,height: 32)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("\(post.userFirstName) \(post.userLastName)")
                            .font(.system(size: 12))
                            .bold()
                            .foregroundColor(Color("mode"))
                        
                        Text(post.userName)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                

                Spacer()
                
                if let date = formatter.date(from: post.publishedDate.description) {
                    let interval = Date().timeIntervalSince(date)
                    
                    if interval < 3600 { // dakika hesaplama
                        let minutesAgo = Int(interval / 60)
                        Text("\(minutesAgo) dakika önce")
                            .foregroundColor(.gray)
                            .font(.caption)
                    } else if interval < 86400 { // saat hesaplama
                        let hoursAgo = Int(interval / 3600)
                        Text("\(hoursAgo) saat önce")
                            .foregroundColor(.gray)
                            .font(.caption)
                    } else { // gün hesaplama
                        let daysAgo = Int(interval / 86400)
                        Text("\(daysAgo) gün önce")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                } else {
                    Text("Geçersiz tarih")
                        .foregroundColor(.gray)
                        .font(.caption)
                }


            }
            
            Text(post.text)
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
                    Text(post.repliesPost.count.description)
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
                    Text(post.likedIDs.count.description)
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
