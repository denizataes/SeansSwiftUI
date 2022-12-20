//
//  ActorSearchRowView.swift
//  Seans
//
//  Created by Deniz Ata Eş on 21.12.2022.
//

import SwiftUI
import Kingfisher

struct ActorSearchRowView: View {
    var actor: Actor
    var body: some View {
        ZStack{
            
            GeometryReader{proxy in
                let size = proxy.size
            
                KFImage(URL(string: "\(Statics.URL)\(actor.profile_path)" ))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .shadow(radius: 10)
                   // .tag(index)
            
            
                let color: Color = .black
                // Custom Gradient
                LinearGradient(colors: [
       
                    .black.opacity(0.5),
                    //color.opacity(0.1),
                    //color.opacity(0.1),
                        
                        
                ], startPoint: .leading, endPoint: .trailing)
            
                // Blurred Overlay
                Rectangle()
                    .fill(.ultraThinMaterial.opacity(0.9))
            }
            .ignoresSafeArea()
            HStack{
                
                KFImage(URL(string: "\(Statics.URL)\(actor.profile_path)" ))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 70)
                    .cornerRadius(10)
                    .clipShape(Rectangle())
                    .shadow(radius: 10)
                
                
                VStack(alignment: .leading, spacing: 5){
                    Text("\(actor.name ?? "")")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.leading)
                
                Spacer()
            }
            .padding(.leading)
            
            
            
        }.frame(height: 90)
    }
}


