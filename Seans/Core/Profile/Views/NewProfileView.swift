//
//  NewProfileView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 22.02.2023.
//

import SwiftUI
import Kingfisher
import GoogleSignIn
import GoogleSignInSwift
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct NewProfileView: View {
    @Namespace var animation
    @State private var selectedFilter: TweetFilterViewModel  = .feeds
    
    @State var editUser: Bool = false
    private var selectedUserUID: String = ""
    let currentDate = Date()
    let formatter = DateFormatter()
    
    let strokeColor = Color(UIImage(named: "profile")?.averageColor ?? .systemGray3)
    
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var currentUserUID: String = ""
    @ObservedObject var viewModel: ProfileViewModel
    
    
    
    init(userUID: String){
        self.selectedUserUID = userUID
        self.viewModel = ProfileViewModel(userUID: userUID)
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.timeZone = TimeZone.current
    }
    
    var body: some View {
        
        
        
        ScrollView{
            
            profileSection
            
            followerSection
            
            buttons
            
            tweetFilterBar
            
            postsView
            
        }
        .sheet(isPresented: $editUser, content: {
            if let user = viewModel.user{
                NewRegisterView(onUpdate: {
                    
                    viewModel.fetchUser(userUID: currentUserUID)
                    
                }, user: user, fromRegister: false)
                .presentationDetents([.large])
                
            }
        })
        
        .navigationTitle("\(viewModel.user?.userName ?? "")")
        .toolbar {
            Menu {
                Button("Çıkış Yap",role: .destructive, action: logout)
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(Color(.systemOrange))
            }
        }
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(Color(.systemOrange))
            }
            
            
        }
        .refreshable {
            viewModel.fetchUser(userUID: selectedUserUID)
            viewModel.fetchPost(userUID: selectedUserUID)
        }
        
        
        
    }
    
    func logout(){
        
        print(currentUserUID)
        print(logStatus)
        //print(profileURL)
        print(userNameStored)
        try? Auth.auth().signOut()
        logStatus = false
        currentUserUID = ""
        userNameStored = ""
        profileURL = nil
    }
}


func editProfile(){
    
}

struct NewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NewProfileView(userUID: "8jMHSAae28RPj5jLDz57oX16G4r2")
    }
}

extension NewProfileView{
    
    var profileSection: some View{
        VStack(alignment: .center){
            
            Button {
                editUser.toggle()
            } label: {
                if let image = URL(string: viewModel.user?.userProfileURL ?? ""){
                    KFImage(image)
                        .placeholder {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(.systemPurple)))
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(color: strokeColor, radius: 4)
                        .overlay(Circle().stroke(strokeColor, lineWidth: 2))
                        .padding(.leading)
                        .padding(.trailing)
                }
                else{
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                        .shadow(color: strokeColor, radius: 4)
                        .overlay(Circle().stroke(strokeColor, lineWidth: 2))
                        .padding(.leading)
                        .padding(.trailing)
                }
            }
            
            Text("\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")")
                .font(.headline)
                .padding(.bottom,4)
            
            if let userBio = viewModel.user?.userBio, userBio != ""{
                Text(userBio)
                    .font(.system(size: 10))
                    .padding(.bottom,10)
                    .foregroundColor(Color(.systemGray))
                    .frame(width: 180)
            }
            
            
        }
        
    }
}

extension NewProfileView{
    var tweetFilterBar: some View{
        HStack{
            
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.system(size: 14))
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color("mode") : .gray)
                    
                    if selectedFilter == item{
                        Capsule()
                            .foregroundColor(Color(.systemPurple))
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 2)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
        .padding(.top)
        .padding(.leading)
        .padding(.trailing)
        .overlay(Divider().offset(x: 0, y: 24).padding())
    }
    
    var postsView: some View{
        VStack{
            if let posts = viewModel.posts, posts.count > 0{
                LazyVStack(spacing: 0){
                    ForEach(posts) { post in
                        PostRowView(post: post) { updatedPost in
                            if let index = posts.firstIndex(where: { post
                                in
                                post.id == updatedPost.id
                            }){
                                viewModel.posts?[index].likedIDs = updatedPost.likedIDs
                            }
                            
                        } onDelete: {
                            /// Removing Post From The array
                            withAnimation(.easeInOut(duration: 0.25)){
                                viewModel.posts?.removeAll { post.id == $0.id }
                            }
                        }
                    }
                }
            }
            else{
                Text("Henüz gönderisi yok 😞")
                    .font(.caption)
                    .padding(.top)
            }
            
        }
    }
    
    var followerSection: some View{
        HStack(spacing: 52){
            
            VStack(spacing: 6){
                Text("\(viewModel.posts?.count ?? 0)")
                    .bold()
                    .font(.system(size: 16))
                Text("Gönderiler")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.darkGray))
            }
            
            VStack(spacing: 6){
                Text("\(viewModel.user?.follow.count ?? 0)")
                    .bold()
                    .font(.system(size: 16))
                Text("Takip")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.darkGray))
            }
            
            VStack(spacing: 6){
                Text("\(viewModel.user?.follower.count ?? 0)")
                    .bold()
                    .font(.system(size: 16))
                Text("Takipçi")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.darkGray))
            }
            
            VStack(spacing: 6){
                if let posts = viewModel.posts {
                    let movieIDs = Set(posts.map { $0.movieID })
                    Text("\(movieIDs.count)")
                        .bold()
                        .font(.system(size: 16))
                }
                else{
                    Text("0")
                        .bold()
                        .font(.system(size: 16))
                }
                Text("Film")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.darkGray))
            }
            
            
        } // buttons
        .padding(.bottom, 24)
    }
    
    var buttons: some View{
        HStack{
            Button {
                guard selectedUserUID != currentUserUID else {return} // Kendi kullanıcıysa takip etme özelliği kapatılsın.
                guard let user = viewModel.user else {return}
                print("Selected User UID : \(selectedUserUID)")
                print("Kullanıcı User UID : \(currentUserUID)")
                var isFollow: Bool = false
                print("şuan ekrandaki kullanıcının takipçileri: \(user.follower)")
                if user.follower.contains(currentUserUID){
                    isFollow = true
                }
                viewModel.followUser(currentUserUID: currentUserUID, followUserID: selectedUserUID, isFollow: isFollow)
            } label: {
                
                if viewModel.user?.userUID != currentUserUID{
                    
                    Button {
                        guard selectedUserUID != currentUserUID else {return} // Kendi kullanıcıysa takip etme özelliği kapatılsın.
                        guard let user = viewModel.user else {return}
                        print("Selected User UID : \(selectedUserUID)")
                        print("Kullanıcı User UID : \(currentUserUID)")
                        var isFollow: Bool = false
                        print("şuan ekrandaki kullanıcının takipçileri: \(user.follower)")
                        if user.follower.contains(currentUserUID){
                            isFollow = true
                        }
                        viewModel.followUser(currentUserUID: currentUserUID, followUserID: selectedUserUID, isFollow: isFollow)
                        
                    } label: {
                        
                        if let follower = viewModel.user?.follower, follower.contains(currentUserUID) {
                            Image(systemName: "person.badge.minus")
                            Text("Takipten Çıkar")
                        }
                        else{
                            Image(systemName: "person.badge.plus")
                            Text("Takip Et")
                        }
                    }
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.bordered)
                    .tint(.purple)
                    
                }
                else{
                    VStack{
                        Button {
                            editUser.toggle()
                        } label: {
                            HStack{
                                Image(systemName: "gear")
                                Text("Düzenle")
                            }
                        }
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.bordered)
                        .tint(Color(.systemGreen))
                        
                        HStack(spacing: 4){
                            Image(systemName: "clock.arrow.2.circlepath")
                                .resizable()
                                .frame(width: 18,height: 16)
                                .foregroundColor(.gray)
                            
                            if let date = formatter.date(from: viewModel.user?.updatedDate.description ?? "") {
                                let interval = Date().timeIntervalSince(date)
                                
                                if interval < 60 { // saniye hesaplama
                                    let secondsAgo = Int(interval)
                                    Text("\(secondsAgo) saniye önce")
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                } else if interval < 3600 { // dakika hesaplama
                                    let minutesAgo = Int(interval / 60)
                                    Text("\(minutesAgo) dakika önce")
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                } else if interval < 86400 { // saat hesaplama
                                    let hoursAgo = Int(interval / 3600)
                                    Text("\(hoursAgo) saat önce")
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                } else { // gün hesaplama
                                    let daysAgo = Int(interval / 86400)
                                    Text("\(daysAgo) gün önce")
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                }
                            } else {
                                Text("Geçersiz tarih")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
