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
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    let formatter = DateFormatter()
    var post: Post?

    @ObservedObject var viewModel: ReplyPostViewModel

    init(post: Post) {
        self.post = post
        self.viewModel = ReplyPostViewModel(postID: post.id ?? "")
        formatter.dateFormat = "HH:mm • dd.MM.yyyy"
        formatter.timeZone = TimeZone.current
    }
    
    var body: some View {
        
        VStack{
            ScrollView(showsIndicators: false){
                ScrollViewReader { proxy in
                    
                    VStack(alignment: .leading){
                        postHeader
                        
                        postText
                        
                        postFooter
                    }
                    
                    Divider()
                    
                    if !viewModel.replyPosts.isEmpty {
                        ForEach(viewModel.replyPosts, id: \.publishedDate){ post in
                            PostRowView(post: post, onUpdate: { n in
                                
                            }, onDelete: {
                                
                            }, isSecond: true)
                            .padding(.leading)
                            .padding(.trailing)
                            
                        }
                        
                    }
                }

            }
            
            Spacer()
            
            TextField(
                "Yanıtla...",
                text: $replyText
            )
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        replyPost()
                    } label: {
                        Text("Yanıtla")
                            .foregroundColor(Color(.systemPurple))
                            .bold()
                            .disableWithOpacity(replyText.count > 0 ? false : true)
                    }
                }
            }
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
        .overlay{
            if viewModel.isLoading{
                CustomLoadingView()
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
        }
    }
    
    func replyPost(){
        closeKeyboard()
        guard let postID = post?.id else {return}
        
        let post = NewPost(id: UUID().uuidString, text: replyText, movieID: 0, movieName: "", moviePhoto: "", actorID: 0, actorName: "", actorPhoto: "", userUID: userUID, postPhoto: "")
        viewModel.replyPost(postID: postID, post: post) { result in
            switch result{
            case .success(_):
                replyText = ""
                viewModel.fetchReplyPosts(postID: postID)
            case .failure(let error):
                print("hata var: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Displayin Errors as Alert
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            viewModel.errorMessage = error.localizedDescription
            viewModel.showError.toggle()
        })
    }
}

struct ReplyPostView_Previews: PreviewProvider {
    static var previews: some View {
        ReplyPostView(post: .init(text: "ata", movieID: 1, movieName: "ata", moviePhoto: "ata", userName: "", userUID: "", userFirstName: "", userLastName: "", actorName: "", actorID: 2, actorPhoto: "", postPhoto: ""))
    }
}

extension ReplyPostView{
    
    var postHeader: some View{
        NavigationLink {
            if let userUID = post?.userUID{
                NewProfileView(userUID: userUID)
            }
        } label: {
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
                        .foregroundColor(.primary)
                    
                    Text("@\(post?.userName ?? "")")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray))
                }
                
                Spacer()
            }
            .padding()
        }
 
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
                
                if let likedUserIDs = post?.likedIDs, likedUserIDs.count > 0 {
                    NavigationLink {
                        UserListView(userUIDs: likedUserIDs, title: "Beğeniler")
                    } label: {
                        HStack(spacing: 4){
                            Text(post?.likedIDs.count.description ?? "0")
                                .bold()
                                .foregroundColor(.primary)
                            Text("Beğeni")
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                }
                else{
                    HStack(spacing: 4){
                        Text("0")
                            .bold()
                            .foregroundColor(.primary)
                        Text("Beğeni")
                            .foregroundColor(Color(.systemGray))
                    }
                }
                
                
                HStack(spacing: 4){
                    Text(post?.repliesPost.count.description ?? "0")
                        .bold()
                    Text("Yanıt")
                        .foregroundColor(Color(.systemGray))
                }
                

                Spacer()
            }
            .padding(.leading)
            .font(.system(size: 12))
        }
    }
}
