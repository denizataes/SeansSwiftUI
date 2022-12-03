//
//  FilmSecondRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct FilmSecondRowView: View {
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                NavigationLink {
                    FilmInfoView()
                } label: {
                    Image("joker")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90,height: 120)
                        .cornerRadius(15)
                }

             
                
                    VStack(alignment: .leading){
                        Text("Joker")
                            .font(.subheadline)
                            .bold()
                    
                        
                        Text("Suç")
                            .font(.system(size: 8))
                            .foregroundColor(.gray)
                    
                }
            }
        }
    }
}

struct FilmSecondRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmSecondRowView()
    }
}
