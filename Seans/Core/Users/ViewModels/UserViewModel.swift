//
//  ExploreViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.12.2022.
//

import Foundation
class UserViewModel: ObservableObject{
    
    @Published var output: String = ""
    @Published var input: String = ""
    @Published var typing = false
    @Published var searchableUsers = [User]()
    @Published var users = [User]()
    @Published var isLoading = false
    
    let dbManager = DatabaseManager()
    
    
    init(userUIDs: [String]){
        isLoading = true
        fetchUsers(userUIDs: userUIDs)
    }
    
    func filterUsers(){
        if self.input.isEmpty {
            self.searchableUsers = []
        } else {
            self.searchableUsers = self.users.filter { user in
                return user.userName.lowercased().contains(self.input.lowercased())
            }
        }
    }

    
    func fetchUsers(userUIDs: [String]) {
        isLoading = true
        dbManager.fetchUsers(userUIDs: userUIDs) { [weak self] users in
            guard let users = users,
            let strongSelf = self else { return }
            strongSelf.isLoading = false
            strongSelf.users = users
        }
    }
}
