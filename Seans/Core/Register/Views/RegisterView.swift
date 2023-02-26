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
    @State var firstName: String = ""
    @State var lastName: String = ""
    
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
    
    

    
    @ObservedObject var viewModel = RegisterViewModel()
    
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
                                .aspectRatio(contentMode: .fill)
                        }
                        else{
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                                .opacity(0.4)
                                .overlay(
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 36, height: 36)
                                        .foregroundColor(Color(.systemPurple))
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
                
                VStack{
                    
                    VStack(alignment: .leading){
                        TextField("Adı", text: $firstName)
                            .textContentType(.username)
                            .border(1, Color(.systemPurple).opacity(0.5))
                            .padding(.top, 25)
                        if userName.isEmpty{
                            Text("Ad Girmelisiniz!")
                                .font(.system(size: 10))
                                .foregroundColor(Color(.systemRed))
                                .bold()
                                .padding(.leading)
                        }
                    }
                    
                    VStack(alignment: .leading){
                        TextField("Soyadı", text: $lastName)
                            .textContentType(.username)
                            .border(1, Color(.systemPurple).opacity(0.5))
                            
                        if userName.isEmpty{
                            Text("Soyadı Girmelisiniz!")
                                .font(.system(size: 10))
                                .foregroundColor(Color(.systemRed))
                                .bold()
                                .padding(.leading)
                        }
                    }
                    
                    
                    VStack(alignment: .leading){
                        TextField("Kullanıcı adı", text: $userName)
                            .textContentType(.username)
                            .border(1, Color(.systemPurple).opacity(0.5))
                            
                        if userName.isEmpty{
                            Text("Kullanıcı Adı Girmelisiniz!")
                                .font(.system(size: 10))
                                .foregroundColor(Color(.systemRed))
                                .bold()
                                .padding(.leading)
                        }
                    }
                    
                    
                    VStack(alignment: .leading){
                        TextField("Email", text: $emailID)
                            .textContentType(.emailAddress)
                            .border(1, Color(.systemPurple).opacity(0.5))
                        if emailID.isEmpty{
                            Text("Email Girmelisiniz!")
                                .font(.system(size: 10))
                                .foregroundColor(Color(.systemRed))
                                .bold()
                                .padding(.leading)
                        }
                    }
                    VStack(alignment: .leading){
                        SecureField("Şifre", text: $password)
                            .textContentType(.emailAddress)
                            .border(1, Color(.systemPurple).opacity(0.5))
                        if password.isEmpty{
                            Text("Şifre Girmelisiniz!")
                                .font(.system(size: 10))
                                .foregroundColor(Color(.systemRed))
                                .bold()
                                .padding(.leading)
                        }
                    }
                    
                    TextField("Kendini kısaca anlat...", text: $userBio, axis: .vertical)
                        .frame(minHeight: 100,alignment: .top)
                        .textContentType(.emailAddress)
                        .border(1, Color(.systemPurple).opacity(0.5))
                    
                    ForEach(SocialMediaType.allCases, id: \.rawValue){
                        socialMedia in
                        SocialMediaTextView(socialMediaName: socialMedia)
                    }
                    //sosyal medya bilgilerini almada problem var bakılacak.
                    
                    Button{
                        registerUser()
                    } label: {
                        Text("Kaydol")
                            .foregroundColor(.white)
                            .hAlign(.center)
                            .fillView(Color(.systemPurple))
    
                    }
                    .disableWithOpacity( userName == "" || emailID == "" || password == "")
                    .padding(.top, 10)
                    
                }
            }
            .overlay(content: {
               // LoadingView(show: $viewModel.isLoading)
                if viewModel.isLoading{
                    CustomLoadingView()
                }
            })
            // MARK: Displaying Alert
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            }
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
    
    // MARK: Displaying Error VIA Alert
    func setError(_ error: Error)async{
        // MARK: UI Must be updated on main thread
        await MainActor.run(body: {
            viewModel.errorMessage = error.localizedDescription
            viewModel.showError.toggle()
        })
    }
    
    
    func registerUser(){
        closeKeyboard()
//        let user = User(firstName: firstName, lastName: lastName, userName: userName, userBio: userBio, userUID: "", userEmail: emailID, password: password, instagramProfileURL: instagramUsername, twitterProfileURL: twitterUsername, userProfilePicData: userProfilePicData, follow: [], follower: [], updatedDate: Date())
        //viewModel.insertUser(user: user)
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
