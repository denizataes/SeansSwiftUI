//
//  UserListView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 1.03.2023.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss
    var title: String
    
    init(userUIDs: [String], title: String){
        viewModel = UserViewModel(userUIDs: userUIDs)
        self.title = title
    }
    var body: some View {
        VStack{
            HStack{
                TextField("Kullanıcı ara...", text: $viewModel.input, onEditingChanged: {
                    self.viewModel.typing = $0
                }, onCommit: {
                    self.viewModel.$output = self.viewModel.$input
                })
                .onChange(of: viewModel.input, perform: { newValue in
                    self.viewModel.output = self.viewModel.input
                    viewModel.filterUsers()
                })
                .padding(8)
                .padding(.horizontal,24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity,alignment: .leading)
                            .padding(.leading,8)
                        Spacer()
                        Button {
                            viewModel.input = ""
                            viewModel.searchableUsers = []
                            
                        } label: {
                            Image(systemName: "multiply")
                                .padding(.trailing,8)
                                .foregroundColor(.purple)
                                .bold()
                        }
                        
                    }
                )
            }
            .padding()
            
            ScrollView{
                
                if !viewModel.input.isEmpty {
                    ForEach(viewModel.searchableUsers, id: \.userUID){ user in
                        NavigationLink {
                            NewProfileView(userUID: user.userUID)
                        } label: {
                            UserRowView(user: user)
                        }
                    }
                }
                else
                {
                    ForEach(viewModel.users, id: \.userUID){ user in
                        NavigationLink {
                            NewProfileView(userUID: user.userUID)
                        } label: {
                            UserRowView(user: user)
                        }
                    }
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.automatic)
        
    }
}
