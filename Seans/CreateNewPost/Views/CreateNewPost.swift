//
//  CreateNewPost.swift
//  SocialMediaApp
//
//  Created by Deniz Ata Eş on 13.02.2023.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift
import FirebaseFirestore
import Kingfisher

struct CreateNewPost: View {
    /// - CallBacks
    var onPost: (() -> ())?
    /// - Post Properties
    ///
    @State private var postText: String = ""
    @State private var postImageData: Data?
    /// - Stored User Data From UserDefaults(AppStorage)

    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    @AppStorage("user_first_name") private var firstName: String = ""
    @AppStorage("user_last_name") private var lastName: String = ""
    /// - View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showMoviePicker: Bool = false
    @State private var showActorPicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyboard: Bool
    
    @State var selectedMovie: Movie?
    @State var selectedActor: Actor?
    
    
    @ObservedObject var viewModel = CreatePostViewModel()


    
    var body: some View {
        VStack{
            HStack{
                Button {
                    dismiss()
                } label: {
                    Text("İptal")
                        .foregroundColor(Color(.systemRed))
                }

                
                Spacer()
                
                
                Button {
                   createPost()
                    
                } label: {
                    Text("Seansla")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                        .padding(.vertical, 6)
                        .background(Color(.systemPurple), in: Capsule())
                }
                .disableWithOpacity(postText == "")
            }
            .padding(.horizontal, 15)
            .padding(.vertical,10)
            .background{
                Rectangle()
                    .fill(.gray.opacity(0.05))
                    .ignoresSafeArea()
            }
            
            if let movie = selectedMovie{
                HStack(spacing: 12){
                    
                    KFImage(URL(string: "\(Statics.URL)\(movie.artwork)" ))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64,height: 80)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    
                    VStack(alignment: .leading, spacing: 8){
                        Text(movie.movieTitle)
                            .font(.title2)
                        
                        HStack{
                            Image(systemName: "clock.fill")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .foregroundColor(Color(.systemGreen))
                            Text(movie.movieTime)
                                .font(.system(size: 12))
                                .foregroundColor(Color(.systemGreen))
                        }
                        HStack{
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .foregroundColor(Color(.systemYellow))
                            Text(String(format: "%.1f", movie.vote_average))
                                .font(.system(size: 12))
                                .foregroundColor(Color(.systemYellow))
                        }
                    }
                    
                    
                    Spacer()
                    
                    
                }
                .overlay(alignment: .topTrailing){
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)){
                            self.selectedMovie = nil
                        }
                    } label: {
                        Image(systemName: "trash")
                            .fontWeight(.bold
                            )
                            .tint(.red)
                    }
                    .padding(10)
                    
                }
                .padding()
            }
            else if selectedActor != nil {
                HStack(spacing: 12){
                    
                    KFImage(URL(string: "\(Statics.URL)\(selectedActor!.profile_path)" ))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64,height: 80)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    
                    VStack(alignment: .leading, spacing: 8){
                        Text(selectedActor?.name ?? "")
                            .font(.title2)
                    
                    }
                    
                    
                    Spacer()
                    
                    
                }
                .overlay(alignment: .topTrailing){
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)){
                            self.selectedActor = nil
                        }
                    } label: {
                        Image(systemName: "trash")
                            .fontWeight(.bold
                            )
                            .tint(.red)
                    }
                    .padding(10)
                    
                }
                .padding()
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    TextField("Düşüncelerini belirt...", text: $postText, axis: .vertical)
                        .focused($showKeyboard)
                        .foregroundColor(Color(.systemPurple))
                    
                    if let postImageData, let image = UIImage(data: postImageData){
                        GeometryReader{
                            let size = $0.size
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            /// - Delete
                                .overlay(alignment: .topTrailing){
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.25)){
                                            self.postImageData = nil
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                            .fontWeight(.bold
                                            )
                                            .tint(.red)
                                    }
                                    .padding(10)
                                    
                                }
                        }
                        .clipped()
                        .frame(height: 220)
                    }
                }
                .padding(15)
            }
            
            Divider()
            
            HStack{
                HStack(spacing: 30){
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        VStack(spacing: 4){
                            Image(systemName: "photo.on.rectangle")
                                .font(.title2)
                                .foregroundColor(Color(.systemPurple))
                            Text("Resim Ekle")
                                .font(.system(size: 10))
                                .foregroundColor(Color(.systemPurple))
                        }
                        
                    }
                    
                    Button {
                        showMoviePicker.toggle()
                    } label: {
                        VStack(spacing: 4){
                            Image(systemName: "film")
                                .font(.title2)
                                .foregroundColor(Color(.systemPurple))
                            Text("Film Ekle")
                                .font(.system(size: 10))
                                .foregroundColor(Color(.systemPurple))
                        }
                    }
                    .sheet(isPresented: $showMoviePicker) {
                        FilmSelectorView(onFilmSelected: { selectedMovie in
                            // Handle the selected movie here, e.g. pass it to CreateNewPost
                            self.selectedMovie = selectedMovie
                        })
                    }
                    .disableWithOpacity(selectedActor != nil)
                    
                    Button {
                        showActorPicker.toggle()
                    } label: {
                        VStack(spacing: 4){
                            Image(systemName: "person")
                                .font(.title2)
                                .foregroundColor(Color(.systemPurple))
                            Text("Aktör Ekle")
                                .font(.system(size: 10))
                                .foregroundColor(Color(.systemPurple))
                        }
                    }
                    .hAlign(.leading)
                    .sheet(isPresented: $showActorPicker) {
                        ActorSelectorView { actor in
                            self.selectedActor = actor
                            print(actor.name)
                        }
                    }
                    .disableWithOpacity(selectedMovie != nil)
                    
                }
                Spacer()
                
                
                Button {
                    showKeyboard = false
                } label: {
                    Text("Tamam")
                        .foregroundColor(Color(.systemPurple))
                }
                
            }
            .foregroundColor(.black)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .vAlign(.top)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue{
                Task{
                    if let rawImageData = try? await newValue.loadTransferable(type: Data.self),
                       let image = UIImage(data: rawImageData),
                       let compressedImageData = image.jpegData(compressionQuality: 0.5){
                        // UI Must be done on Main Thread
                        
                        await MainActor.run(body: {
                            postImageData = compressedImageData
                            photoItem = nil
                        })
                    }
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        /// - Loading View
        .overlay{
            //LoadingView(show: $viewModel.isLoading)
            if viewModel.isLoading{
                CustomLoadingView()
            }
        }

    }
    
    // MARK: Post Content to Firebase
    
    func createPost() {
        closeKeyboard()
        showKeyboard = false
        
        var moviePhoto = ""
        var movieID = 0
        var movieName = ""
        
        var actorID = 0
        var actorName = ""
        var actorPhoto = ""
        
        if let selectedMovie = selectedMovie {
            if !selectedMovie.artwork.isEmpty {
                moviePhoto = "\(Statics.URL)\(selectedMovie.artwork)"
            }
            
            movieID = selectedMovie.id
            movieName = selectedMovie.movieTitle
        }
        
        if let selectedActor = selectedActor {
            if !selectedActor.profile_path.isEmpty {
                actorPhoto = "\(Statics.URL)\(selectedActor.profile_path)"
            }
            
            actorID = selectedActor.id
            actorName = selectedActor.name ?? ""
            
        }
        
        let post = NewPost(text: postText, movieID: movieID, movieName: movieName, moviePhoto: moviePhoto, actorID: actorID, actorName: actorName,actorPhoto: actorPhoto, userUID: userUID, postImageData: postImageData, postPhoto: "")
        
        viewModel.createPost(post: post) { result in
            switch result {
            case .success:
                onPost?()
                dismiss()
            case .failure(let error):
                errorMessage = error.localizedDescription
                showError.toggle()
            }
        }
    }


    // MARK: Displayin Errors as Alert
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

struct CreateNewPost_Previews: PreviewProvider {
    static var previews: some View {
       CreateNewPost()
    }
}
