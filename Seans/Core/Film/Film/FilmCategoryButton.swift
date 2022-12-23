//
//  FilmCategoryButton.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct FilmCategoryButton: View {
    var buttonName: String
    var body: some View {
        HStack{
            Text(buttonName)
                .font(.system(size: 9)).bold()
                .frame(width: 60,height: 32)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
        }
            
    }
}

struct FilmCategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        FilmCategoryButton(buttonName: "Drama")
    }
}
