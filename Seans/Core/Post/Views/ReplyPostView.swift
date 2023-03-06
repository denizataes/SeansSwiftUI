//
//  ReplyPostView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 7.03.2023.
//

import SwiftUI
import Kingfisher

struct ReplyPostView: View {
    @State private var replyText: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    let formatter = DateFormatter()
    var post: Post?
    
    init(post: Post) {
        self.post = post
        formatter.dateFormat = "HH:mm • dd.MM.yyyy"
        formatter.timeZone = TimeZone.current
    }
    
    var body: some View {
        
        VStack{
            ScrollView{
                VStack(alignment: .leading){
                    postHeader
                    
                    postText
                    
                    postFooter
                }
                
                Divider()
            }
            
            Spacer()
            
            TextField(
                "Yanıtla...",
                text: $replyText
            )
            .foregroundColor(Color(.systemPurple))
            .accentColor(Color(.systemPurple))
            .border(0.5, Color(.systemGray).opacity(0.5))
            .padding(.leading, 2)
            .padding(.trailing, 2)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

        //            .navigationTitle(post?.actorID != nil && post!.actorID > 0  ? (post?.actorName ?? "") : (post?.movieID != nil && post!.movieID > 0) ? (post?.movieName ?? "") : "Seans" )
        .navigationTitle("Yanıtla 🤔")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let moviePhoto = post?.moviePhoto, moviePhoto != ""{
                    
                    NavigationLink {
                        if let movieID = post?.movieID{
                            NewFilmInfoView(movieID: movieID)
                        }
                    } label: {
                        VStack(spacing: 1){
                            KFImage(URL(string: "\(moviePhoto)" ))
                                .resizable()
                                .frame(width: 28,height: 36)
                                .cornerRadius(5)
                            Text(post?.movieName ?? "")
                                .font(.system(size: 8))
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    
                }
                
                
                if let actorPhoto = post?.actorPhoto, actorPhoto != ""{
                    
                    NavigationLink {
                        if let actorID = post?.actorID{
                            NewActorView(id: actorID)
                        }
                    } label: {
                        VStack(spacing: 1){
                            KFImage(URL(string: "\(actorPhoto)"))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .clipShape(Circle())
                                .shadow(radius: 1)
                            
                            Text("\(post?.actorName ?? "")")
                                .font(.system(size: 8))
                                .foregroundColor(Color(.systemGray))
                        }
                        
                    }
                }
            }
        }
    }
}

//struct ReplyPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReplyPostView()
//    }
//}

extension ReplyPostView{
    
    var postHeader: some View{
        HStack(spacing: 8){
            KFImage(post?.userProfileURL)
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .shadow(radius: 1)
            
            VStack(alignment: .leading, spacing:4){
                Text("\(post?.userFirstName ?? "") \(post?.userLastName ?? "")")
                    .font(.system(size: 16))
                    .bold()
                
                Text("@\(post?.userName ?? "")")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))
            }
            
            Spacer()
            
            
            
        }
        .padding()
    }
    
    var postText: some View {
        VStack{
            if let postText = post?.text {
                Text(postText)
                    .padding(.leading)
                    .padding(.trailing)
            }
        }
    }

    
    var postFooter: some View{
        VStack(alignment: .leading){
            if let publishedDate = post?.publishedDate{
                Text(formatter.string(from: publishedDate))
                    .padding(.top,1)
                    .padding(.leading)
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray))
                
                Divider()
            }
            
            
            
            HStack(spacing: 12){
                HStack(spacing: 4){
                    Text(post?.likedIDs.count.description ?? "0")
                        .bold()
                    Text("Beğeni")
                        .foregroundColor(Color(.systemGray))
                }
                
                HStack(spacing: 4){
                    Text(post?.repliesPost.count.description ?? "0")
                        .bold()
                    Text("Yanıt")
                        .foregroundColor(Color(.systemGray))
                }
                Spacer()
                HStack(spacing: 20){
                    Image(systemName: post?.likedIDs.contains(userUID) ?? false  ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color(.systemRed))
                    
                    Image(systemName: "popcorn")
                        .resizable()
                        .frame(width: 16, height: 21)
                        .foregroundColor(Color(.systemPurple))
                }
                .padding(.trailing)
            }
            .padding(.leading)
            .font(.system(size: 12))
        }
    }
}
