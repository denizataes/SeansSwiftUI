//
//  FilmGridView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 3.12.2022.
//

import SwiftUI

struct AllFilmView: View {
    var data: [Int] = Array(1...20)
    let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    @ObservedObject var viewmodel = AllFilmViewModel()
    
    var body: some View {
        ZStack{
            BGView()
            ScrollView{
                VStack{
                    ForEach(Category.allCases, id: \.rawValue){ category in
                        FilmSecondRowView(films: viewmodel, category: category)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func BGView()->some View{
        GeometryReader{proxy in
            let color: Color = .black
           //  Custom Gradient
//            LinearGradient(colors: [
//                .black.opacity(0.9),
//                .black.opacity(0.8),
//                .black.opacity(0.7),
//                color.opacity(0.6),
//                color.opacity(0.5),
//                color.opacity(0.4),
//                .purple
//            ], startPoint: .top, endPoint: .bottom)

//             Blurred Overlay
//            Rectangle()
//                .fill(.ultraThinMaterial)
            
            Color(.black)
                
            
            //Color(red: 234/255, green: 182/255, blue: 118/255).opacity(0.8)
            
      
        }
        .ignoresSafeArea()
    }
}

struct FilmGridView_Previews: PreviewProvider {
    static var previews: some View {
        AllFilmView()
    }
}
