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
import GoogleSignIn
import GoogleSignInSwift

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

                if let user = user{
                    strongSelf.dbManager.getUserProfileImageURL(with: user.userUID) { url in
                        strongSelf.logStatus = true
                        strongSelf.userUID = user.userUID
                        strongSelf.userNameStored = user.userName
                        strongSelf.profileURL = URL(string: url)
                        strongSelf.isLoading = false
                    }
                    
                }
                
            case .failure(let error):
                strongSelf.isLoading = false
                strongSelf.errorMessage = error.localizedDescription
                strongSelf.showError.toggle()
            }
        }
    }

    
    func signUpWithGoogle() {
        isLoading = true
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ApplicationUtility.rootViewController) { [weak self] user, error in
            guard self != nil else { return }
            if let error = error {
                print("Google ile giriş yapılırken hata oluştu -> \(error.localizedDescription)")
                return
            }
            guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                guard let strongSelf = self else { return }
                if let error = error {
                    print("Google ile giriş yapılırken hata oluştu -> \(error.localizedDescription)")
                    return
                }
                guard let user = result?.user else { return }
                
                if let userProfile = result?.additionalUserInfo?.profile {
                    let firstName = userProfile["given_name"] as? String ?? ""
                    let lastName = userProfile["family_name"] as? String ?? ""
                    let userName = userProfile["name"] as? String ?? ""
                    let email = user.email ?? ""
                    strongSelf.dbManager.userExistsWithEmail(email, completion: { success in
                        if !success{
                            if let profilePhoto = user.photoURL {
                                URLSession.shared.dataTask(with: profilePhoto) { (data, response, error) in
                                    if let error = error {
                                        print("Google profil fotoğrafı bilgileri alınırken hata oluştu -> \(error.localizedDescription)")
                                        return
                                    }
                                    if let data = data {
                                        DispatchQueue.main.async {
                                            let insertUser = User(firstName: firstName, lastName: lastName, userName: userName, userBio: "", userUID: user.uid, userEmail: email, password: "", instagramProfileURL: "", twitterProfileURL: "", snapchatProfileURL: "", tiktokProfileURL: "", youtubeProfileURL: "", userProfileURL: "", userProfilePicData: data)
                                            strongSelf.dbManager.saveUser(with: insertUser) { [weak self] result in
                                                guard let strongSelf = self else { return }
                                                switch result {
                                                case .success(()):
                                                    strongSelf.dbManager.getUserProfileImageURL(with: user.uid) { url in
                                                        strongSelf.userUID = user.uid
                                                        strongSelf.userNameStored = userName
                                                        strongSelf.logStatus = true
                                                        print(url)
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
                                }.resume()
                            } else {
                                let insertUser = User(firstName: firstName, lastName: lastName, userName: userName, userBio: "", userUID: user.uid, userEmail: email, password: "", instagramProfileURL: "", twitterProfileURL: "", snapchatProfileURL: "", tiktokProfileURL: "", youtubeProfileURL: "", userProfileURL: "", userProfilePicData: nil)
                                strongSelf.dbManager.saveUser(with: insertUser) { [weak self] result in
                                    guard let strongSelf = self else { return }
                                    switch result {
                                    case .success(()):
                                        strongSelf.dbManager.getUserProfileImageURL(with: user.uid) { url in
                                            strongSelf.userUID = user.uid
                                            strongSelf.userNameStored = userName
                                            strongSelf.logStatus = true
                                            print(url)
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
                        else{
                            strongSelf.dbManager.getUserProfileImageURL(with: user.uid) { url in
                                strongSelf.userUID = user.uid
                                strongSelf.userNameStored = userName
                                strongSelf.logStatus = true
                                print(url)
                                strongSelf.profileURL = URL(string: url)
                                strongSelf.isLoading = false
                            }
                            
                        }
                    })
                } else {
                    strongSelf.isLoading = false
                    strongSelf.errorMessage = "Kullanıcı bilgilerinde eksiklik olduğu için giriş yapılamadı!"
                    strongSelf.showError.toggle()
                }

                
              

                
            }
            
        }
        
    }
    
    
}
