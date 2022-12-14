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
        
            MainTabView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}
