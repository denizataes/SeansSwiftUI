//
//  FilmGridView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct FilmGridView: View {
    var title: String
    var data: [Int] = Array(1...20)
    let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.largeTitle)
                .padding()
                .bold()
            
            
            ScrollView{
                LazyVGrid(columns: adaptiveColumns,spacing: 10){
                    ForEach(data, id: \.self){
                        number in
                        ZStack{
                            FilmSecondRowView()
                        }
                    }
                }
            }
        }
    }
}

struct FilmGridView_Previews: PreviewProvider {
    static var previews: some View {
        FilmGridView(title: "Vizyondakiler")
    }
}
