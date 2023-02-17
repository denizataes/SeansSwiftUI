//
//  DatabaseManager.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.02.2023.
//

import Foundation
import FirebaseDatabase
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    func insertUser(with user: User, completion: @escaping (Result<(), Error>) -> Void){
        Auth.auth().createUser(withEmail: user.userEmail, password: user.password){ result, error in
            if let error = error {
                print("DEBUG: kayıt aşamasında hata oluştu -> \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let userUID = Auth.auth().currentUser?.uid else {
                print("DEBUG: kayıt aşamasında hata oluştu -> \(error?.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            var data = [
                "userUID": userUID,
                "firstName": user.firstName,
                "lastName": user.lastName,
                "userName": user.userName,
                "userBio": user.userBio,
                "userEmail": user.userEmail,
                "instagramProfileURL": user.instagramProfileURL,
                "twitterProfileURL": user.twitterProfileURL,
                "snapchatProfileURL": user.snapchatProfileURL,
                "tiktokProfileURL": user.tiktokProfileURL,
                "youtubeProfileURL": user.youtubeProfileURL,
                "userProfileURL": user.userProfileURL
            ]
            //
            //            if let userProfileURL = user.userProfileURL {
            //                data["userProfileURL"] = userProfileURL
            //            }
            //
            Firestore.firestore().collection("Users").document(userUID).setData(data){ error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let userProfilePicData = user.userProfilePicData {
                    StorageManager.shared.uploadProfilePicture(with: userProfilePicData, userUID: userUID) {[weak self] result in
                        guard let strongSelf = self else { return }
                        switch result {
                        case .success(let url):
                            strongSelf.updateProfilePhoto(with: url, uid: userUID) { updateError in
                                if let updateError = updateError {
                                    completion(.failure(updateError))
                                    return
                                }
                                completion(.success(()))
                            }
                        case .failure(let error):
                            strongSelf.deleteUser()
                            completion(.failure(error))
                        }
                    }
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    func updateProfilePhoto(with url: String, uid: String, completion: ((Error?) -> Void)? = nil) {
        Firestore.firestore().collection("Users").document(uid).updateData(["userProfileURL": url]) { error in
            if let completion = completion {
                completion(error)
            }
        }
    }
    
    func deleteUser(){
        Auth.auth().currentUser?.delete(completion: { error in
            if let error = error{
                print("DEBUG: kullanıcının silinmesi esnasında hata oluştu -> \(error.localizedDescription)")
                return
            }
            guard let uid = Auth.auth().currentUser?.uid else{return}
            Firestore.firestore().collection("Users").document(uid).delete()
        })
    }
    func login(email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else {
                completion(.failure(NSError(domain: "com.example.domain", code: 400, userInfo: [NSLocalizedDescriptionKey: "Authentication failed"])))
                
                return
            }
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let userUID = Auth.auth().currentUser?.uid else {
                completion(.failure(NSError(domain: "com.example.domain", code: 400, userInfo: [NSLocalizedDescriptionKey: "Authentication failed"])))
                return
            }
            
            strongSelf.fetchUser(withUid: userUID) { user in
                completion(.success(user))
            }
        }
    }
    
    public func userExistsWithEmail(_ email: String, completion: @escaping ((Bool) -> Void)) {
        Firestore.firestore().collection("Users")
            .whereField("userEmail", isEqualTo: email)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error checking user existence with email: \(email) - \(error.localizedDescription)")
                    completion(false)
                } else {
                    guard let snapshot = querySnapshot else {
                        completion(false)
                        return
                    }
                    completion(!snapshot.documents.isEmpty)
                }
            }
    }
    
    public func getUserProfileImageURL(with uid: String, completion: @escaping ((String) -> Void)) {
        Firestore.firestore().collection("Users")
            .whereField("userUID", isEqualTo: uid)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting user profile image with uid : \(uid) - \(error.localizedDescription)")
                    completion("")
                } else {
                    guard let snapshot = querySnapshot, let document = snapshot.documents.first else {
                        completion("")
                        return
                    }
                    let profileURL = document.data()["userProfileURL"] as? String ?? ""
                    print("profil fotoğrafı: \(profileURL)")
                    completion(profileURL)
                }
            }
    }

    
    
    
    func fetchUser(withUid uid: String, completion: @escaping (User?) -> Void){
        Firestore.firestore().collection("Users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else {
                    completion(nil)
                    return
                }
                
                guard let user = try? snapshot.data(as: User.self) else {
                    completion(nil)
                    return
                }
                
                completion(user)
            }
    }
    
    func saveUser(with user: User, completion: @escaping (Result<(), Error>) -> Void){
        let data = [
            "userUID": user.userUID,
            "firstName": user.firstName,
            "lastName": user.lastName,
            "userName": user.userName,
            "userBio": user.userBio,
            "userEmail": user.userEmail,
            "instagramProfileURL": user.instagramProfileURL,
            "twitterProfileURL": user.twitterProfileURL,
            "snapchatProfileURL": user.snapchatProfileURL,
            "tiktokProfileURL": user.tiktokProfileURL,
            "youtubeProfileURL": user.youtubeProfileURL,
            "userProfileURL": user.userProfileURL
        ]
        
        Firestore.firestore().collection("Users").document(user.userUID).setData(data){ error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let userProfilePicData = user.userProfilePicData {
                StorageManager.shared.uploadProfilePicture(with: userProfilePicData, userUID: user.userUID) {[weak self] result in
                    guard let strongSelf = self else { return }
                    switch result {
                    case .success(let url):
                        strongSelf.updateProfilePhoto(with: url, uid: user.userUID) { updateError in
                            if let updateError = updateError {
                                completion(.failure(updateError))
                                return
                            }
                            @AppStorage("user_profile_url") var profileURL: URL?
                            profileURL = URL(string: url)
                            completion(.success(()))
                        }
                    case .failure(let error):
                        strongSelf.deleteUser()
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.success(()))
            }
        }
    }
    
//    func signInWithGoogle(){
//
//        // 1
//        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
//            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
//                authenticateUser(for: user, with: error)
//            }
//        } else {
//            // 2
//            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//            // 3
//            let configuration = GIDConfiguration(clientID: clientID)
//
//            // 4
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
//
//            // 5
//            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
//                authenticateUser(for: user, with: error)
//            }
//        }
//
//    }
//
//     func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
//      // 1
//      if let error = error {
//        print(error.localizedDescription)
//        return
//      }
//
//      // 2
//      guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
//
//      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
//
//      // 3
//      Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
//        if let error = error {
//          print(error.localizedDescription)
//        } else {
//
//        }
//      }
//    }

    
    
    
}
