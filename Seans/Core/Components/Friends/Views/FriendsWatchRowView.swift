//
//  FriendsWatchRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct FriendsWatchRowView: View {
    var body: some View {
        HStack{
            NavigationLink {
                ProfileView()
            } label: {
                Image("idil")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24,height: 24)
                    .clipShape(Circle())
            }
            
            NavigationLink {
                ProfileView()
            } label: {
                Image("ugur")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24,height: 24)
                    .clipShape(Circle())
            }
            
            NavigationLink {
                ProfileView()
            } label: {
                Image("emre")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24,height: 24)
                    .clipShape(Circle())
            }

            Text("...")
                .font(.callout)
                .foregroundColor(.gray)
            
            
            
        }
    }
}

struct FriendsWatchRowView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsWatchRowView()
            
    }
}
