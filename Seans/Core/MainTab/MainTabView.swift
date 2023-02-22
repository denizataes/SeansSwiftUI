//
//  MainTabView.swift
//  TwitterSwiftUI
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage("user_UID") var userUID: String = ""
    var body: some View {
        
        
        TabView {
            NavigationView{
                FeedView()
            }
                .tabItem {
                    Image(systemName: "house")
                    Text("Gönderiler")
                }
            NavigationView{
                ExploreView()
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Ara")
                }
            NavigationView{
                Home()
            }
                .tabItem {
                    Image(systemName: "film")
                    Text("Keşfet")
                }
            
            NavigationView{
                NewProfileView(userUID: userUID)
            }
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profil")
                }
        }
        .accentColor(.purple)
        
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
