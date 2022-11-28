//
//  ContentView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack{
            MainTabView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Seans")
        .toolbar{
//            ToolbarItem(placement: .navigationBarLeading)
//            {
//                NavigationLink {
//                    withAnimation(.easeInOut){
//                       ProfileView()
//
//                    }
//                } label: {
//
//                    //KFImage(URL(string: user.profileImageUrl))
//                    Image("profile")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 32, height: 32)
//                        .clipShape(Circle())
//
//
//                }
//            }
           
//            ToolbarItem(placement: .navigationBarTrailing)
//            {
//                NavigationLink {
//                    withAnimation(.easeInOut){
//                       MessagesView()
//                    }
//                } label: {
//                    Image(systemName: "message")
//                        .foregroundColor(.gray)
//
//                }
//            }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
