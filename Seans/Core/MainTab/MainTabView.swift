//
//  MainTabView.swift
//  TwitterSwiftUI
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    var body: some View {
        
        TabView(selection: $selectedIndex){
            
                FeedView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem{
                    Image(systemName: "house")
                }.tag(0)
            
            ExploreView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            PostView()
            .onTapGesture {
                self.selectedIndex = 2
            }
            .tabItem{
                Image(systemName: "plus")
            }.tag(2)
        
            
                FilmView()
                
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem{
                    Image(systemName: "film")
                }.tag(3)
            
            
            
            ProfileView()
            .onTapGesture {
                self.selectedIndex = 4
            }
            .tabItem{
                Image(systemName: "person.crop.circle")
            }.tag(4)
            
     
        }
        .accentColor(.purple)

    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
