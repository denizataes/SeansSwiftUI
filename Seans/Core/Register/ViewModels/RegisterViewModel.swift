//
//  FilmViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 14.12.2022.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI

class RegisterViewModel: ObservableObject{
    let dbManager = DatabaseManager()
    @Published var isLoading = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_first_name") private var firstName: String = ""
    @AppStorage("user_last_name") private var lastName: String = ""
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    func insertUser(user: User){
        isLoading = true
        dbManager.insertUser(with: user) {[weak self] result in
            guard let strongSelf = self else {return}
            switch result{
            case .success():
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                strongSelf.dbManager.getUserProfileImageURL(with: userUID) { url in
                    strongSelf.firstName = user.firstName
                    strongSelf.lastName = user.lastName
                    strongSelf.logStatus = true
                    strongSelf.userUID = userUID
                    strongSelf.userNameStored = user.userName
                    strongSelf.profileURL = URL(string: url)
                    strongSelf.isLoading = false
                }
                

                
            case .failure(let error):
                strongSelf.isLoading = false
                strongSelf.errorMessage = error.localizedDescription
                strongSelf.showError.toggle()
            }
        }
    }
    
}
