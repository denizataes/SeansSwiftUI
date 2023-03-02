//
//  PostRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 27.11.2022.
//

import SwiftUI
import Kingfisher
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

struct PostRowView: View {
    /// - CallBacks
    var onUpdate: (NewPost) -> ()
    var onDelete: () -> ()
    
    var post: Post
    @State private var isLiked = false
    let currentDate = Date()
    let formatter = DateFormatter()
    @State private var docListener: ListenerRegistration?
    @ObservedObject var viewModel = PostRowViewModel()
    @AppStorage("user_UID") var userUID: String = ""
    
    init(post: Post, onUpdate: @escaping (NewPost) -> (), onDelete: @escaping () -> ()) {
        self.post = post
        self.onUpdate = onUpdate
        self.onDelete = onDelete
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.timeZone = TimeZone.current
        print(post.postPhoto)
    }
    
    
    
    var body: some View {
        //   ZStack{
        // background
        
        
        
        VStack(alignment: .leading){
            HStack{
                if post.actorID > 0||post.movieID > 0{
                    leftSide
                }
                profilSection
            }
            if !post.postPhoto.isEmpty{
                GeometryReader{
                    let size = $0.size
                    KFImage(URL(string: post.postPhoto))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .clipped()
                .frame(height: 220)
            }
            buttons
        }
        .padding()
        
        //.frame(height: 250)
        .overlay(alignment: .topTrailing){
            /// Displaying Delete Button ( if it's Author of that post)
            if post.userUID == userUID{
                Menu{
                    Button("Gönderiyi Sil", role: .destructive, action: deletePost)
                }label: {
                    Image(systemName: "ellipsis")
                        .font(.caption)
                        .rotationEffect(.init(degrees: -90))
                        .foregroundColor(Color(.systemPurple))
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .offset(x: 8)
            }
        }
        .onAppear{
            /// - Adding Only once
            if docListener == nil{
                guard let postID = post.id else{return}
                docListener = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({ snapshot, error in
                    if let snapshot{
                        if snapshot.exists{
                            /// - Document
                            /// Fetcihng Updated Document
                            if let updatedPost = try? snapshot.data(as: NewPost.self){
                                onUpdate(updatedPost)
                            }
                        }else{
                            ///- Document Deleted
                            onDelete()
                        }
                    }
                })
            }
        }
        .onDisappear{
            // MARK: Applying SnapShot Listener only when the post is available on the screen
            // Else removing the listener(it saves unwanted live eupdates from the posts which has swiped away screen)
            if let docListener{
                docListener.remove()
                self.docListener = nil
            }
        }
        
        Divider()
        
    }
    
    func deletePost(){
        guard let postID = post.id else{return}
        viewModel.deletePost(postID: postID)
    }
    
    func likePost(){
        guard let postID = post.id else{return}
        var isLiked: Bool = false
        if post.likedIDs.contains(userUID){
            isLiked = true
        }
        viewModel.likePost(postID: postID, isLiked: isLiked)
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
        VStack(alignment: .leading){
            NavigationLink {
                if post.movieID > 0{
                    FilmInfoView(movie: .init(id: post.movieID, movieTitle: post.movieName, releaseDate: "", movieTime: "", movieDescription: "", artwork: post.moviePhoto))
                }
                else if post.actorID > 0 {
                    NewActorView(id: post.actorID)
                }
                
                
            } label: {
                KFImage(URL(string: post.movieID > 0 ? "\(post.moviePhoto)" : "\(post.actorPhoto)" ))
                    .resizable()
                    .frame(width:110 ,height: 150)
                    .cornerRadius(20)
                    .shadow(radius: 15)
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(post.movieID > 0 ? post.movieName : post.actorName)
                    .font(.subheadline)
                    .lineLimit(nil)
                    .bold()
            }
            .frame(maxWidth: 100)
            .fixedSize(horizontal: false, vertical: true)
            
            
            
            
        }
    }
    
    var profilSection: some View{
        
        VStack(alignment: .leading){
            HStack{
                
                NavigationLink {
                    NewProfileView(userUID: post.userUID)
                    
                } label: {
                    KFImage(post.userProfileURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: post.actorID > 0||post.movieID > 0 ? 32 : 48,height: post.actorID > 0||post.movieID > 0 ? 32 : 48)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text("\(post.userFirstName) \(post.userLastName)")
                            .font(.system(size: post.actorID > 0||post.movieID > 0 ? 12 : 16))
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
                    
                    if interval < 60 { // saniye hesaplama
                        let secondsAgo = Int(interval)
                        Text("\(secondsAgo) saniye önce")
                            .foregroundColor(.gray)
                            .font(.caption)
                    } else if interval < 3600 { // dakika hesaplama
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
        .padding(.top,10)
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
                likePost()
            } label: {
                HStack{
                    Image(systemName: post.likedIDs.contains(userUID)  ? "heart.fill" : "heart")
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
