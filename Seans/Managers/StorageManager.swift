//
//  StorageManager.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.02.2023.
//
import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    
    ///Uploads picture to firebase storage and returns completion with url string to downlaod
    public func uploadProfilePicture(with data: Data, userUID: String,completion: @escaping (Result<String, Error>) -> Void){
        storage.child("Profile_Images/\(userUID)").putData(data,metadata: nil) { metadata, error in
            
            guard error == nil else {
                print("Veri tabanına fotoğraf yüklenirken hata oluştu.")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("Profile_Images/\(userUID)").downloadURL { url, error in
                
                guard let url = url else {
                    print("")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download URL returned: \(urlString)")
                completion(.success(urlString))
                
            }
            
        }
    }
        
        ///Uploads post photo to firebase storage and returns completion with url string to downlaod
        public func uploadPostPhoto(with data: Data, userUID: String,completion: @escaping (Result<String, Error>) -> Void){
            let imageReferenceID = "\(userUID)\(Date())"
            storage.child("Post_Images/\(imageReferenceID)").putData(data,metadata: nil) { metadata, error in
                
                guard error == nil else {
                    print("Post'a ait fotoğrafı Veri tabanına yüklenirken hata oluştu.")
                    completion(.failure(StorageErrors.failedToUpload))
                    return
                }
                
                self.storage.child("Post_Images/\(imageReferenceID)").downloadURL { url, error in
                    
                    guard let url = url else {
                        print("")
                        completion(.failure(StorageErrors.failedToGetDownloadUrl))
                        return
                    }
                    
                    let urlString = url.absoluteString
                    print("download URL returned: \(urlString)")
                    completion(.success(urlString))
                    
                }
                
            }
        
        func downloadURL(for path: String,  completion: @escaping (Result<URL, Error>) -> Void){
            let reference = storage.child(path)
            
            reference.downloadURL { url, error in
                guard let url = url, error == nil else {
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                completion(.success(url))
            }
            
        }
    }
    
    public enum StorageErrors: Error{
        case failedToUpload
        case failedToGetDownloadUrl
    }
    
}
