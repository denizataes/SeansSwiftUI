//
//  FeedView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct FeedView: View {
    @State private var createNewPost: Bool = false
    @ObservedObject var viewModel = FeedViewModel()
    var body: some View {
      //  NavigationStack{
            ZStack(alignment: .bottomTrailing) {
                ScrollView{
                    if let posts = viewModel.posts {
                        LazyVStack(spacing: 0){
                            ForEach(posts) { post in
                                PostRowView(post: post) { updatedPost in
                                    if let index = posts.firstIndex(where: { post
                                        in
                                        post.id == updatedPost.id
                                    }){
                                        viewModel.posts?[index].likedIDs = updatedPost.likedIDs
                                    }
                                    
                                } onDelete: {
                                    /// Removing Post From The array
                                    withAnimation(.easeInOut(duration: 0.25)){
                                        viewModel.posts?.removeAll { post.id == $0.id }
                                    }
                                }

                            }
                        }
                    }
                    
                }
            }
           // .navigationTitle("Gönderiler")
          //  .navigationBarTitleDisplayMode(.large)
        //}
        .refreshable {
            viewModel.posts = nil
            viewModel.fetchPosts()
        }
        .overlay{
            LoadingView(show: $viewModel.isLoading)
        }
        .overlay(alignment: .bottomTrailing){
            Button {
                createNewPost.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.white))
                    .padding(13)
                    .background(Color(.systemPurple), in: Circle())
            }
            .padding(15)
            
        }
//        .fullScreenCover(isPresented: $createNewPost) {
//            CreateNewPost()
//        }
        
        .fullScreenCover(isPresented: $createNewPost) {
            CreateNewPost { post in
                viewModel.posts?.insert(post, at: 0)
            }
        }
        
        
        
        
    }
}
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
