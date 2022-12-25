//
//  TrailersView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 25.12.2022.
//

import SwiftUI

struct TrailersView: View {
    
    @ObservedObject var viewModel: TrailersViewModel
    
    init(id: Int){
        self.viewModel = TrailersViewModel(id: id)
    }
    
    var body: some View {
        
        if(viewModel.trailers.count > 0){
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 10){
                    ForEach(viewModel.trailers) { trailer in
                        
                        VideoView(videoID: trailer.key ?? "")
                            .frame(width: viewModel.trailers.count == 1 ? 320 : 200,height: 150)
                            .cornerRadius(12)
                            .shadow(radius: 10)
                    }
                }
                
            }
            .padding()
        }
    }
}

