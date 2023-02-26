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
        ZStack {
            if let posts = viewModel.posts {
                ScrollView{
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
                .overlay(
                    Group {
                        if viewModel.isLoading {
                            CustomLoadingView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color(.systemBackground).opacity(0.5))
                    .opacity(viewModel.isLoading ? 1 : 0)
                    , alignment: .center
                )
                .overlay(
                    Button(action: {
                        createNewPost.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.white))
                            .padding(13)
                            .background(Color(.systemOrange), in: Circle())
                            .shadow(radius: 5)
                    })
                    .padding(15)
                    , alignment: .bottomTrailing
                )

            } else {
            
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            createNewPost.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.white))
                                .padding(13)
                                .background(Color(.systemOrange), in: Circle())
                                .shadow(radius: 5)
                        })
                        .padding()
                    }
                }
            }
        }
        .navigationTitle("Gönderiler")
        .navigationBarTitleDisplayMode(.large)
        .refreshable {
            viewModel.posts = nil
            viewModel.fetchPosts()
        }
        .overlay{
            //LoadingView(show: $viewModel.isLoading)
            if viewModel.isLoading{
                CustomLoadingView()
            }
        }
        .fullScreenCover(isPresented: $createNewPost) {
            CreateNewPost {
                viewModel.fetchPosts()
            }
        }
    }
}
