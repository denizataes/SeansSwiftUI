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
        ZStack(alignment: .bottomTrailing) {
            ScrollView{
                if let posts = viewModel.posts {
                    LazyVStack{
                        ForEach(posts) { post in
                            PostRowView(post: post)
                        }
                    }
                }

            }
        }
        .refreshable {
            viewModel.posts = nil
            viewModel.fetchPosts()
            
            print("refresh")
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
