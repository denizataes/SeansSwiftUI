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
    
    init(userUIDs: [String]){
        viewModel = UserViewModel(userUIDs: userUIDs)
    }
    var body: some View {
      
        NavigationView {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Kapat")
                            .foregroundColor(.primary)
                    }

                }
            }
        }
        
    }
    
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView()
//    }
//}
