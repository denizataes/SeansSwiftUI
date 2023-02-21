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
        
        TabView{
            
            FeedView()
                .tabItem{
                    Image(systemName: "house")
                }
            
            ExploreView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }
            
            Home()
                .tabItem{
                    Image(systemName: "film")
                }
            ProfileView(userUID: userUID)
                .tabItem{
                    Image(systemName: "person.crop.circle")
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
