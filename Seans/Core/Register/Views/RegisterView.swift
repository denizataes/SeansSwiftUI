//
//  RegisterView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 16.02.2023.
//

import SwiftUI
import PhotosUI

struct RegisterView: View {
    
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var userBioLink: String = ""
    
    // MARK: SocialMedia Properties
    @State var instagramUsername: String = ""
    @State var twitterUsername: String = ""
    @State var snapchatUsername: String = ""
    @State var tiktokUsername: String = ""
    @State var youtubeUsername: String = ""
    @State var userProfilePicData: Data?
    
    //MARK: View Properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    @State private var birthDate = Date.now
    
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                    
                    ZStack{
                        if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .aspectRatio(contentMode: .fill)
                        }
                        else{
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                                .opacity(0.4)
                                .overlay(
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 36, height: 36)
                                        .foregroundColor(Color(.blue))
                                        .shadow(radius: 5)
                                )
                                .clipShape(Circle())
                            
                            
                            
                            
                            
                        }
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .contentShape(Circle())
                    .padding(.top, 25)
                    .onTapGesture {
                        showImagePicker.toggle()
                    }
                    
                    TextField("Kullanıcı adı", text: $userName)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.5))
                        .padding(.top, 25)
                    
                    TextField("Email", text: $emailID)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.5))
                    
                    
                    SecureField("Şifre", text: $password)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.5))
                    
                    
                    TextField("Kendini kısaca anlat...", text: $userBio, axis: .vertical)
                        .frame(minHeight: 100,alignment: .top)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.5))
                    
                    
                    HStack {
                        Image("instagram")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .shadow(radius: 10)
                        
                        TextField("Instagram Kullanıcı Adı", text: $userBioLink)
                            .textContentType(.emailAddress)
                            .border(1, .gray.opacity(0.5))
                    }
                    
                    HStack {
                        Image("twitter")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .shadow(radius: 10)
                        
                        TextField("Twitter Kullanıcı Adı", text: $userBioLink)
                            .textContentType(.emailAddress)
                            .border(1, .gray.opacity(0.5))
                    }
                    
                    HStack {
                        Image("snapchat")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .shadow(radius: 10)
                    
                        
                        TextField("Snapchat Kullanıcı Adı", text: $userBioLink)
                            .textContentType(.emailAddress)
                            .border(1, .gray.opacity(0.5))
                    }
                    
                    
                    HStack {
                        Image("youtube")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .shadow(radius: 10)
                        
                        TextField("Youtube Kullanıcı Adı", text: $userBioLink)
                            .textContentType(.emailAddress)
                            .border(1, .gray.opacity(0.5))
                    }
                
                
                HStack {
                    Image("tiktok")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .shadow(radius: 10)
                    
                    TextField("Tiktok Kullanıcı Adı", text: $userBioLink)
                        .textContentType(.emailAddress)
                        .border(1, .gray.opacity(0.5))
                }
                
                
//                Button{
//
//                } label: {
//                    Text("Kaydol")
//                        .foregroundColor(.white)
//                        .hAlign(.center)
//                        .fillView(Color(.systemPurple))
//
//                }
//                .disableWithOpacity(userName == "" || userBio == "" || emailID == "" || password == "" || userProfilePicData == nil)
//                .padding(.top, 10)

                    
                .padding()
                .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
                .onChange(of: photoItem) { newValue in
                    // MARK: Extracting UIImage from PhotoItem
                    if let newValue{
                        Task{
                            do{
                                guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
                                // MARK: UI Must be updated on Main Thread
                                await MainActor.run(body: {
                                    userProfilePicData = imageData
                                })
                            }catch{
                                
                            }
                        }
                    }
                }
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Geri")
                            .foregroundColor(Color(.systemPurple))
                    }
                    
                }
            }
            
            
        }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
