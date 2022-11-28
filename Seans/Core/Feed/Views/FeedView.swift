//
//  FeedView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 26.11.2022.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            ScrollView{
                LazyVStack{
                    ForEach(1..<50) { index in
                        PostRowView()
                            .padding(.trailing)
                            .padding(.leading)
                            .padding(.vertical,5)
                            .padding(.top,10)
                    }
                    
                }
            }
            
        }
    }
}
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
