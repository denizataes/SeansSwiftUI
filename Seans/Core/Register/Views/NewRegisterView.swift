//
//  NewRegisterView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 23.02.2023.
//

import SwiftUI
import PhotosUI
import Kingfisher
import FirebaseAuth

struct NewRegisterView: View {
    var onUpdate: (() -> ())?
    var user: User?
    
    var fromRegister: Bool
    
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    // MARK: SocialMedia Properties
    @State var instagramUsername: String = ""
    @State var twitterUsername: String = ""
    @State var userProfileImage: String = ""
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
        
        NavigationView{
            ScrollView{
                VStack{
                    header
                    
                    HStack{
                        imagePicker
                        
                        CustomTextField(isPassword: false, isRequired: true, name: "Adı", imageName: "person", text: $firstName, bigText: false)
                    }
                    
                    CustomTextField(isPassword: false, isRequired: true, name: "Soyadı", imageName: "person", text: $lastName, bigText: false)
                    
                    CustomTextField(isPassword: false, isRequired: true, name: "Kullanıcı Adı", imageName: "person", text: $userName, bigText: false)
                    
                    if fromRegister{ // sadece kayıt ekranından geldiğinde şifreyi göster.
                        CustomTextField(isPassword: true, isRequired: true, name: "Şifre", imageName: "lock", text: $password, bigText: false)
                    }
                    
                    CustomTextField(isPassword: false, isRequired: true, name: "Email", imageName: "envelope", text: $emailID, bigText: false)
                        .disableWithOpacity(!fromRegister)
                    
                    CustomTextField(isPassword: false, isRequired: false, name: "Kendini tanıt", imageName: "person.text.rectangle", text: $userBio, bigText: true)
                        
                    VStack(alignment: .leading){
                        HStack{
                            Text("Sosyal Medya Hesapların")
                                .font(.headline)
                            
                            
                            Text("(Zorunda Değil)")
                                .font(.caption2)
                                .foregroundColor(Color(.darkGray))
                            
                            
                        }
                        HStack{
                            SocialMediaTextField(socialMedia: "twitter", text: $twitterUsername)
                            Spacer()
                            SocialMediaTextField(socialMedia: "instagram", text: $instagramUsername)
                        }
                     
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .onAppear{
                userName = user?.userName ?? ""
                firstName = user?.firstName ?? ""
                lastName = user?.lastName ?? ""
                emailID = user?.userEmail ?? ""
                userBio = user?.userBio ?? ""
                userProfileImage = user?.userProfileURL ?? ""
                twitterUsername = user?.twitterProfileURL ?? ""
                instagramUsername = user?.instagramProfileURL ?? ""
            }
            .overlay(content: {
                LoadingView(show: $viewModel.isLoading)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        saveButton()
                    } label: {
                        Text(fromRegister ? "Kaydet" : "Güncelle")
                            .foregroundColor(.primary)
                            .bold()
                    }
                    .disableWithOpacity(fromRegister ? (lastName == "" || firstName == "" || userName == "" || emailID == "" || password == "") : (firstName == "" || lastName == ""))
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Kapat")
                            .foregroundColor(.primary)
                            .bold()
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
    
    
    func saveButton(){
        closeKeyboard()
        
        var user = User(firstName: firstName, lastName: lastName, userName: userName, userBio: userBio, userUID: "", userEmail: emailID, password: password, instagramProfileURL: instagramUsername, twitterProfileURL: twitterUsername, userProfileURL: "", userProfilePicData: userProfilePicData, follow: [], follower: [], updatedDate: Date())
        if fromRegister{
            viewModel.insertUser(user: user)
        }
        else{
            guard let userUID = Auth.auth().currentUser?.uid else {
                let error = NSError(domain: "com.example.app", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu açık değil"])
                return 
            }
            user.id = userUID
            
            viewModel.updateUser(user: user) { result in
                switch result{
                case .success(()):
                    onUpdate?()
                    dismiss()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

struct NewRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NewRegisterView(fromRegister: true)
    }
}

extension NewRegisterView{
    var header: some View{
        VStack(alignment: .center, spacing: 12){
            
            Text(fromRegister ? "Seans'a katıl." : "Profilimi Düzenle")
                .font(.system(size: 24))
                .bold()
            
            if fromRegister{
                HStack{
                    Text("Zaten hesabın var mı?")
                        .font(.subheadline)
                        .foregroundColor(Color(.darkGray))
                        
                    Button {
                        dismiss()
                    } label: {
                        Text("Giriş Yap")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color(.systemPurple))
                    }

                }
            }
        }
        .padding(.top, 32)
    }
    
    var imagePicker: some View{
        VStack(alignment: .center){
            ZStack{
                if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                else if let userProfileImage = userProfileImage{
                    KFImage(URL(string: userProfileImage))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                else{
                    
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color(.systemGreen))
                        .clipShape(Circle())
                        .border(2, Color(.systemGreen))
                        
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .contentShape(Circle())

            
            Text(userProfilePicData == nil ? "Seç" : "Düzenle")
                .font(.system(size: 12))
                .foregroundColor(Color(.systemGreen))
                .bold()
            
            
        }
        .onTapGesture {
            showImagePicker.toggle()
        }
        .padding()
        
    }
    
    
    
}

struct SocialMediaTextField: View{
    var socialMedia: String
    @Binding var text: String
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            HStack {
                Image(socialMedia)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                    .foregroundColor( text.isEmpty ? Color(.systemBlue) : Color(.systemPurple))
                
//                TextFieldWrapper(text: $text, placeholder: "\(socialMedia.prefix(1).capitalized + socialMedia.dropFirst())", color: (socialMedia == "twitter" ? Color(.systemBlue) : Color(.systemPurple)))
                TextField("\(socialMedia.prefix(1).capitalized + socialMedia.dropFirst())", text: $text)
                    .foregroundColor((socialMedia == "twitter" ? Color(.systemBlue) : Color(.systemPurple)))
                    .font(.callout)
                    .frame(width: 120)

            }
            .frame(height: 30)
            .border(1, socialMedia == "twitter" ? Color(.systemBlue) : Color(.systemPurple))
            .shadow(radius: 0.5)
        }
        

        
        
    }
}

struct CustomTextField: View {
    var isPassword: Bool
    var isRequired: Bool
    var name: String
    var imageName: String
    @Binding var text: String
    var bigText: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Text(name)
                    .font(.headline)
                
                
                Text(isRequired ? "(Zorunlu)" : "(Zorunlu Değil)")
                        .font(.caption2)
                        .foregroundColor(Color(.darkGray))
                
                
            }
            
            HStack {
                Image(systemName: text.isEmpty ? imageName : "\(imageName).fill")
                    .animation(.easeInOut)
                    .foregroundColor( text.isEmpty ? Color(.systemGray) : Color(.systemPurple))
                
                
                if isPassword{
                    SecureField(name, text: $text)
                        .textContentType(.username)
                        .foregroundColor(Color(.systemPurple))
                        
                }else{
                    TextField(name, text: $text)
                        .textContentType(.username)
                        .foregroundColor(Color(.systemPurple))
                        
                }
                
                
            }
            .frame(height: bigText ? 80 : 30)
            .border(1, Color(.systemGray3))
            .shadow(radius: 0.5)
            
        }
        .padding()
    }
    
}
