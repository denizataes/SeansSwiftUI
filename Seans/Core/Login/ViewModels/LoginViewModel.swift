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

class LoginViewModel: ObservableObject{
    let dbManager = DatabaseManager()
    @Published var isLoading = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    func login(email: String, password: String){
        isLoading = true
        dbManager.login(email: email, password: password) { [weak self] result in
            
            guard let strongSelf = self else{return}
            switch result{
            case .success(let user):
                strongSelf.isLoading = false
                if let user = user{
                    strongSelf.logStatus = true
                    strongSelf.userUID = user.userUID
                    strongSelf.userNameStored = user.userName
                    strongSelf.profileURL = user.userProfileURL == "" ? nil : URL(string: user.userProfileURL)
                    
                }
                
            case .failure(let error):
                strongSelf.isLoading = false
                strongSelf.errorMessage = error.localizedDescription
                strongSelf.showError.toggle()
            }
        }
    }
    
}
