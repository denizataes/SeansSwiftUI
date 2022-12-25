//
//  SelectedCategoryViewModel.swift
//  Seans
//
//  Created by Deniz Ata Eş on 25.12.2022.
//

import SwiftUI

struct SelectedCategoryViewModel: View {
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                Text("Kategori butonuna tıklanıldığında bu ekranda o kategoriye ait filmler listelenecek")
                    .font(.title)
                    .padding()
                    .bold()
                    .foregroundColor(.green)
                    .shadow(radius: 10)
                    .border(.black.opacity(0.1))
                Spacer()
            }
            
                
            
        }
      
    }
}

struct SelectedCategoryViewModel_Previews: PreviewProvider {
    static var previews: some View {
        SelectedCategoryViewModel()
    }
}
