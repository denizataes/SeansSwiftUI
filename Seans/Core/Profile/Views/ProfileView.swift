//
//  ProfileView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI
import Kingfisher
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct ProfileView: View {
    
    @Namespace var animation
    @State private var selectedFilter: TweetFilterViewModel  = .feeds
    @State var show = false
    @AppStorage("user_first_name") private var firstName: String?
    @AppStorage("user_last_name") private var lastName: String?
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    @ObservedObject var viewModel = ProfileViewModel()
    
    var socialMedia = ["instagram","twitter","tiktok","youtube", "snapchat"]
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                profileSection
                
                userInfoDetails
                
                tweetFilterBar
                
                ZStack(alignment: .bottomTrailing) {
                    
                    if let posts = viewModel.posts{
                        LazyVStack{
                            ForEach(posts) { post in
                                PostRowView(post: post)
                            }
                        }
                    }
                    
                    
                }.padding(.top)
                
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    logout()
                    
                } label: {
                    Text("Çıkış Yap")
                        .foregroundColor(Color(.systemRed))
                        .bold()
                }
                
                
            }
        }
    }
    
    func logout(){
        try? Auth.auth().signOut()
        logStatus = false
        userUID = ""
        userNameStored = ""
        profileURL = nil
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
extension ProfileView{
    var profileSection: some View{
        HStack{
            HStack {
                Spacer()
                VStack{
                    GeometryReader { geometry in
                        KFImage(profileURL)
                        //                            Image("profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 4))
                            .shadow(radius: 10)
                            .foregroundColor(.init(hue: 0, saturation: 0.0, brightness: 0.9))
                            .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                            .overlay(
                                CircularLayout(radius: (geometry.size.width * 0.8) / 2, name: socialMedia)
                                    .offset(x: geometry.size.width * 0.1, y: geometry.size.width * 0.1)
                            )
                    }
                    
                }
                .frame(height: 180)
                Spacer()
            }
            
            
            VStack(alignment: .leading,spacing: 8){
                HStack{
                    //profileName ANİMASYONLU
                    Text("\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")")
                        .foregroundColor(Color("mode"))
                        .font(.system(size: 20))
                    
                }
                Text("\(viewModel.user?.userName ?? "")")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                
                Text("\(viewModel.user?.userBio ?? "")")
                    .foregroundColor(.gray)
                    .font(.caption2)
                
                Button {
                    
                } label: {
                    HStack{
                        Text("Takip Et")
                            .font(.system(size: 12))
                            .bold()
                            .foregroundColor(.purple)
                        
                        
                        Image(systemName: "person.badge.plus")
                            .resizable()
                            .frame(width: 16,height: 16)
                            .foregroundColor(.purple)
                            .bold()
                    }
                    .frame(width: 90, height: 30)
                    .foregroundColor(.white)
                    .background(LinearGradient(colors: [.gray,.clear,.clear,.clear,.gray], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
            }
            
            
            
            Spacer()
        }
        
        
    }
    
    var profileName: some View{
        ZStack{
            
            Text("Deniz Ata EŞ")
                .foregroundColor(Color("mode"))
                .font(.system(size: 20))
            
            Text("Deniz Ata EŞ")
                .foregroundColor(.purple)
                .font(.system(size: 20))
                .mask{
                    Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [.red,.gray,.black]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 30))
                        .offset(x:self.show ? 100 : -130)
                }
            
        }
        .onAppear{
            withAnimation(Animation.default.speed(0.08).delay(0)
                .repeatForever(autoreverses: false)){
                    self.show.toggle()
                }
        }
    }
    
    var userInfoDetails: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 40)
            {
                
                VStack{
                    Text("Gönderiler")
                        .font(.system(size: 14))
                    Text("10")
                        .font(.system(size: 16))
                        .bold()
                }
                
                VStack{
                    Text("Takipçi")
                        .font(.system(size: 14))
                    Text("165")
                        .font(.system(size: 16))
                        .bold()
                }
                
                VStack{
                    Text("Takip")
                        .font(.system(size: 14))
                    Text("203")
                        .font(.system(size: 16))
                        .bold()
                }
                
                
                VStack{
                    Text("Film")
                        .font(.system(size: 14))
                    Text("212")
                        .font(.system(size: 16))
                        .bold()
                }
                
                VStack{
                    Text("Dizi")
                        .font(.system(size: 14))
                    Text("17")
                        .font(.system(size: 16))
                        .bold()
                }
                
                
                VStack{
                    HStack{
                        Text("Katılma Tarihi")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                        
                        Image(systemName: "calendar.circle")
                            .foregroundColor(.purple)
                    }
                    Text("17 Temmuz 2022")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                }
                
                Spacer()
                
            }
            Divider()
        }
    }
    
    
    var tweetFilterBar: some View{
        HStack{
            
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color("mode") : .gray)
                    
                    if selectedFilter == item{
                        Capsule()
                            .foregroundColor(Color(.systemPurple))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
}


