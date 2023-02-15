//
//  LoginView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 15.02.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State var emailID: String = ""
    @State var password: String = ""
    
    // MARK: View Properties
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    // MARK: App Storage
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            Spacer()
            HStack(alignment: .center){
                Spacer()
                VStack(alignment: .center, spacing: 15){
                    Text("Hoşgeldin 🥳")
                        .font(.system(size: 50))
                        .bold()
                    
                    Text("Seni aramızda görmek harika !")
                        .font(.system(size: 18))
                        .foregroundColor(Color(UIColor.systemGray))
                        .shadow(radius: 40)
                }
                Spacer()
            }
            
            
            
            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .border(2, Color(.systemPurple) .opacity(0.5))
                .padding(.top, 25)
            
            SecureField("Şifre", text: $password)
                .textContentType(.emailAddress)
                .border(2, Color(.systemPurple) .opacity(0.5))
            
            HStack{
                Spacer()
                Button{
                    
                } label: {
                    Text("Şifremi Unuttum")
                        .font(.callout)
                        .fontWeight(.medium)
                        .tint(.gray)
                    
                }
            }
            .padding(.bottom)
            
            
            
            
            Button {
                login()
            } label: {
                // MARK: Login Button
                HStack{
                    Image(systemName: "popcorn")
                        .resizable()
                        .frame(width: 24, height: 32)
                        .foregroundColor(Color(.white))
                    Text("Seans İle Giriş Yap")
                        .font(.title3)
                        .foregroundColor(.white)
                        .hAlign(.center)
                    
                }
                .fillView(Color(.systemPurple))
            }
            .padding(.top, 10)
            
            Button {
                
            } label: {
                // MARK: Login Button
                HStack{
                    Image("facebook")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Facebook İle Giriş Yap")
                        .font(.title3)
                        .foregroundColor(.white)
                        .hAlign(.center)
                    
                }
                .fillView(Color(.systemBlue))
            }
            .padding(.top, 10)
            
            
            Button {
                
            } label: {
                // MARK: Login Button
                HStack{
                    Image("google")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Google İle Giriş Yap")
                        .font(.title3)
                        .foregroundColor(.white)
                        .hAlign(.center)
                    
                }
                .fillView(Color(.darkGray))
            }
            .padding(.top, 10)
            
            HStack{
                Spacer()
                Text("Hesabınız yok mu?")
                    .foregroundColor(Color(.systemGray))
                    .font(.system(size: 16))
                
                Button("Hesap Oluşturun"){
                    createAccount.toggle()
                }
                .fontWeight(.bold)
                .foregroundColor(Color(.systemPurple))
                .font(.system(size: 18))
                Spacer()
            }
            .font(.callout)
            .vAlign(.bottom)
            
        }
        .padding()
        .vAlign(.center)
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
        }
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        
        
        
        //}
    }
    func login(){
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            logStatus = true
        }
        
        
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}
